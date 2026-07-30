event_inherited();

active = false;

forming = true;
active = false;

deathSprite = spr_burnedGroundDeath;

xSide = 1;
ySide = 1;

onGround = true;

damageSounds = [snd_burn];

damTime = 0.5;

bubbles = undefined;

deleteBubbles = function() {

	if(!is_array(bubbles)) exit;
	
	var len = array_length(bubbles);
	
	for (var i = 0; i < len; i++) {
	
		var b = bubbles[i];
		
		if (!instance_exists(b)) continue;
		
		b.die = true;
	
	}
	
}