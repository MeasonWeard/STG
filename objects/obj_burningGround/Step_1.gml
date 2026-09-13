// Inherit the parent event
event_inherited();

if (setupBurn and instance_exists(caster)) {

	setupBurn = false;
	
	var sk = scr_skills_findCharSkill("flammable", caster);
	
	if (sk != undefined) {
	
		burnChance = sk.burnChance;
		burnDamage = sk.burnDamage;
	
	}
	
}