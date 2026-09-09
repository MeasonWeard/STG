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
	if (!instance_exists(char)) exit;
	if (!scr_random_chance(burnChance)) exit;
	
	if (!variable_instance_exists(char, "burn")) char.burn = noone;
	
	if (!instance_exists(char.burn)) {
	
		var burn = instance_create_layer(char.x, char.y, "Instances", obj_burn);
	
		char.burn = burn;
		burn.owner = char;
		
		burn.ticks = 8;
		burn.damage = burnDamage;

	} else {
		
		var burn = char.burn;
		
		burn.ticks = 8;
		
		if (burnDamage > burn.damage.fire) burn.damage = burnDamage;
		
	}
	
}