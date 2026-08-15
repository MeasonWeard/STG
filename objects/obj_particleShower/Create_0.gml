owner = noone;
faction = undefined;
damge = undefined;
areaDamage = undefined;

charHash = global.stageController.charHash;

radius = 100;
particles = 2;
duration = 2;
daReduction = 0;

life = 120;
particleLife = 6;
particleFreq = 1;
particleTick = 0;
particleTick2 = 0;

setup = true;
depth = layers.groundDecorations;

newTick = 16;

alpha = 0;

daCheckTick = 12;

areaDamageTick = 0;

charHashKeys = [];
hash = global.stageController.charHash;

//generate pool
pool = [];
poolLen = 0;

//function for getting particles
getParticle = function() {

	for (var i = 0; i < poolLen; i++) {
	
		var p = pool[i];
		if (!p.active) return p;
		
	}
	
	return noone;
	
}
