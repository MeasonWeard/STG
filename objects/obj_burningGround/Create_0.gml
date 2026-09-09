event_inherited();

active = false;

source = noone;

setupBurn = true;

forming = true;
active = false;

deathSprite = spr_burnedGroundDeath;

xSide = 1;
ySide = 1;

onGround = true;

damageSounds = [snd_burn];

damTime = 0.5;

bubbles = undefined;

radius = 15;

burnChance = 0;
burnDamage = undefined;

effect = function(char) {
	
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

deleteBubbles = function() {

	if(!is_array(bubbles)) exit;
	
	var len = array_length(bubbles);
	
	for (var i = 0; i < len; i++) {
	
		var b = bubbles[i];
		
		if (!instance_exists(b)) continue;
		
		b.die = true;
	
	}
	
}