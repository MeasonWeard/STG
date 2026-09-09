// Inherit the parent event
event_inherited();

if (setupBurn and instance_exists(source)) {

	setupBurn = false;
	
	var sk = scr_skills_findCharSkill("flammable", source);
	
	if (sk != undefined) {
	
		burnChance = sk.burnChance;
		burnDamage = sk.burnDamage;
	
	}
	
}