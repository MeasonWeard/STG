if (life < 1) {
	
	instance_destroy();
	
} else {

	//particles
	if (particleTick >= particleFreq) {

		particleTick -= particleFreq;
	
		var pt = scr_randomPointInCircle(x, y, radius);

		var p = getParticle();
	
		if (p != noone) {
	
			p.active = true;
			p.playSound = true;
			p.canDamage = true;
			p.tick = 0;
			p.x = pt.xx;
			p.y = pt.yy;

		}
	
	}

	particleTick ++;

	if (particleTick2 >= particleFreq) {

		particleTick2 -= particleFreq;
	
		var pt = scr_randomPointInCircle(x, y, radius);

		var p = getParticle();
	
		if (p != noone) {
	
			p.active = true;
			p.playSound = true;
			p.canDamage = true;
			p.tick = 0;
			p.x = pt.xx;
			p.y = pt.yy;

		}

	
	}

	particleTick2 ++;

	//da
	if (daCheckTick > 0) {

		daCheckTick--;
	
	} else {

		daCheckTick = 12;
	
		var nearby = scr_hash_getNearby(charHash, x, y);
		var len = array_length(nearby);
	
		for (var i = 0; i < len; i ++) {
	
			var char = nearby[i];
		
			if (!instance_exists(char)) continue;
			if (char.faction == faction) continue;
		
			var dist = point_distance(x, y, char.x, char.y);
		
			if (dist > radius) continue;
		
			scr_char_addStatMod(char, "da", daReduction, 30, "psDaMod");
				
		}
	
	}

	life --;

}