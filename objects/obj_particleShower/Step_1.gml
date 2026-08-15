if (setup) {
	
	setup = false;	
	
	var cell = scr_hash_getCellAt(x, y);
	var xx = cell.xx;
	var yy = cell.yy;
	
	scr_hash_updateHashKeys(charHashKeys, xx, yy);
	
	life = duration * 60;
	
	particleFreq = (60 / particles) * 2;
	
	particleTick2 = particleFreq * 0.5;
	
	var pSize = ceil(particleLife / particleFreq) * 2 + 2;
	
	//generate pool
	repeat(pSize) {

		var p = instance_create_layer(x, y, "Instances", obj_particle);
		p.maxLife = particleLife;
		p.damage = damage;
		p.faction = faction;
	
		array_push(pool, p);
	
	}

	poolLen = array_length(pool);
	
}