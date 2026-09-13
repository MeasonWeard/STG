event_inherited();

controller = noone;
owner = noone;
angleOffset = 0;
faction = undefined;

damTick = 0;
damTime = 0.5;

charHash = global.stageController.charHash;

damageSounds = [snd_burn];

image_xscale = 1.2;

burnChance = 0;
burnDamage = undefined;

applyBurn = function(char) {
	
	if (burnChance <= 0) exit;
	if (!scr_random_chance(burnChance)) exit;
	
	scr_effects_applyBurn(char, burnDamage);
	
}