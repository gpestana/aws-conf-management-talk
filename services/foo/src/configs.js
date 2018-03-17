const AWS = require('aws-sdk')
const sha1 = require('sha1')

const signature = {
  current: "",
  bootstrap: true
}

module.exports = (entrypointFn, configsChangedFn, opts) => {
	if (!opts) {
		console.log("AWS configs: opts object must be defined")
		process.exit(1)
	}

	const interval = opts.interval || 5000
	const configFile = opts.configFile || './config.json'
	const serviceId = opts.serviceId || 'serviceId'
	const bucket = opts.bucket || 'random-bucket'

	AWS.config.loadFromPath(configFile)
	const s3 = new AWS.S3()

	// start checking for configuration changes
	setInterval(
		() => checkChanges(s3, bucket, serviceId, configsChangedFn), 
	interval)
	
	// loads configurations and starts entrypoiny
	// ...
	entrypointFn({conf:"example"})
}

const checkChanges = (s3, bucket, serviceId, cb) => {

	const listParams = {
  	Bucket: bucket,
  	MaxKeys: 100,
  	Prefix: `${serviceId}/`
 	};

  s3.listObjects(listParams, function(err, data) {
		if (err) {
			console.log(err, err.stack)
			process.exit(err)
		}

		let mods = ""
		const contents = data.Contents
			contents.forEach(c => {
				mods = mods + c.LastModified
			})
			const confSig = sha1(mods)
			if (signature.bootstrap) {
				signature.bootstrap = false
				signature.current = confSig
				return
			}
			if (confSig != signature.current)  {
				cb()
				currentConfSignature = signature
		}
 })
}
