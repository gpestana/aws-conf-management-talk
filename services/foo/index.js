const initConfig = require("./src/configs")

console.log("Hello, I'm Foo. And you?")

// Function called when configurations change
const configsChangedFn = () =>  {
	console.log("Configuration has changed, restarting container")
	process.exit()
}

// Service entrypoint
const entrypoint = confs => {
	console.log("Configurations:")
	console.log(confs)
	console.log("Service bootstrapped. Doing some work now..")
}

 /*
 * entrypoint is the service's entrypoint in which the new configurations will
 * be injected. configsChangedFn is the functions which will be called when 
 * configurations change
 */
const confOpts = {
	configFile: "./config.json",
	serviceId: "foo",
	bucket: "gpestana-conf",
	interval: 5000,
}

initConfig(entrypoint, configsChangedFn, confOpts)

