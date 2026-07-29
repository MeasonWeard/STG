if (setup) {
	
	setup = false;	
	
	life = duration * 60;
	
	particleFreq = (60 / particles) * 2;
	
	particleTick2 = particleFreq * 0.5;
	
	show_debug_message(particleFreq);
	
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