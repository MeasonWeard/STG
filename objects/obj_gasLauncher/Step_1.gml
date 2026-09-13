if (setup) {

	setup = false;

	projectiles = maxProjectiles;
	
	if (instance_exists(owner)) {

		var sk = scr_skills_findCharSkill("caustic", owner);
	
		if (sk != undefined) {
	
			corrodeChance = sk.chance;
			corrodeDamage = sk.damage;
	
		}
	
	}
	
}