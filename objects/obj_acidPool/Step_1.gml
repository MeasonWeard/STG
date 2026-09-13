// Inherit the parent event
event_inherited();

if (setupCorrode and instance_exists(caster)) {

	setupCorrode = false;
	
	var sk = scr_skills_findCharSkill("caustic", caster);
	
	if (sk != undefined) {
	
		corrodeChance = sk.chance;
		corrodeDamage = sk.damage;
	
	}
	
}