event_inherited();

forming = true;
active = false;
radius = 10;

deathSprite = spr_acidPoolDeath;

xSide = 1;
ySide = 1;

onGround = true;

damageSounds = [snd_burn];

image_alpha = 0.85;

flames = undefined;

deleteFlames = function() {

	if(!is_array(flames)) exit;
	
	var len = array_length(flames);
	
	for (var i = 0; i < len; i++) {
	
		var f = flames[i];
		
		if (!instance_exists(f)) continue;
		
		f.die = true;
	
	}
	
}