if (delay) exit;

if (instance_exists(owner) and owner.active) {

	x = owner.x;
	y = owner.y - owner.sprite_height * 0.25;
	
} else {

	instance_destroy();
	
}

if (pulse > 0) {

	pulse -= 0.01;
	
}

if (tick > 0) {

	tick --;
	
} else {
	
	tick = time;
	pulse = 1;
	
	var nearby = scr_hash_getNearby(sc.charHash, x, y);
	var len = array_length(nearby);
	
	for (var i = 0; i < len; i ++) {
	
		var char = nearby[i];
		
		if (!instance_exists(char)) continue;
		
		if (char.faction == faction) continue;
		
		var dist = point_distance(x, y, char.x, char.y);
		
		if (dist > radius) continue;
		
		if (!scr_physics_hasLineOfSight(x, y, char.x, char.y)) continue;
		
		scr_char_damage(char, damage, damageTypes.ability, true);
	
	}
	
	scr_audio_playSoundAt(snd_burn, x, y);
	
}