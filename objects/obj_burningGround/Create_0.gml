event_inherited();

active = false;

caster = noone;
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
	if (!scr_random_chance(burnChance)) exit;
	
	scr_effects_applyBurn(char, burnDamage);
		
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