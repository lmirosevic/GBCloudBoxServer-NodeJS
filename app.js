// Cluster bootstrap
var cluster = require('cluster');
var numCPUs = require('os').cpus().length;

if (cluster.isMaster) {
	// Fork workers
	console.log("Master forking " + numCPUs + " workers!");
	for (var i = 0; i < numCPUs; i++) {
		cluster.fork();
	}

	cluster.on('exit', function(worker, code, signal) {
		console.log('worker ' + worker.process.pid + ' died');
	});
} 
else {
	// Worker starts a server
	require('coffee-script');
	var cloudBox = require('./app/cloud-box.coffee');

	cloudBox.start();
}