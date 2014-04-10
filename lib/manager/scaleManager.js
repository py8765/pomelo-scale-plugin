var path = require('path');
var Operator = require('./operator');

var ScaleManager = function(app, conditions) {
	this.app = app;
	conditions = conditions || {};
	this.cpuConditions = conditions.cpu;
	this.memoryConditions = conditions.memory;
	this.backup = conditions.backup;
	if(!this.backup) {
		throw new Error('no backup servers is available.');
	}
	this.init();
};

module.exports = ScaleManager;

var pro = ScaleManager.prototype;

pro.init = function() {
	this.backup = path.join(this.app.getBase(), this.backup);
	this.availableServers = require(this.backup);
};

pro.start = function() {
	if(!!this.cpuConditions) {
		var cpuOperator = new Operator(this, this.app, this.cpuConditions, 'cpu');
		cpuOperator.start();
	}
	if(!!this.memoryConditions)	{
		var memoryOperator = new Operator(this, this.app, this.memoryConditions, 'memory');
		memoryOperator.start();
	}
};

pro.getAvailableServers = function(type, number) {
	var availables = this.availableServers[type];
	if(number > availables.length) {
		console.error('no enough servers to scale.');
		return null;
	}
	var servers = availables.slice(0, number);
	availables.splice(0, number);
	console.error('availableServers: %j', this.availableServers);
	return servers;
};