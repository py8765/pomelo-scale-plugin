var utils = require('../util/utils');

module.exports = function(app, opts) {
  return new Component(app, opts);
};

var Component = function(app, opts) {
	this.opts = opts || {};
	this.cpuConditions = this.opts.cpu;
	this.memoryConditions = this.opts.memory;
	app.set('conditions', opts);
};

var pro = Component.prototype;

pro.name = '__scale__';