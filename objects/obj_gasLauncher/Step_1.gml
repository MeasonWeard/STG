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
	
	var ir = scr_skills_getRadiationSicknessData(owner, true);
	
	irradiateChance = ir.chance;
	irradiateDamage = ir.damage;
	
}