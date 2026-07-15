//currently only used for destructibles
function scr_env_damage(env, damage, type, ignoreShield) {
	
	if (!instance_exists(env)) return 0;
	if (!is_struct(damage)) return 0;
	
	env.hurt = true;
	
	//randomise damage
	var kin = damage.kin > 0 ? irandom_range(damage.kinMin, damage.kinMax) : 0;
	var fire = damage.fire > 0 ? irandom_range(damage.fireMin, damage.fireMax) : 0;
	var chem = damage.chem > 0 ?irandom_range(damage.chemMin, damage.chemMax) : 0;
	var elec = damage.elec > 0 ?irandom_range(damage.elecMin, damage.elecMax) : 0;
	var rad = damage.rad > 0 ? irandom_range(damage.radMin, damage.radMax) : 0;
	
	//final
	var totalDam = kin + fire + chem + elec + rad;
	
	var lost = min(env.hp, totalDam);
	
	env.hp = max(env.hp - totalDam, 0);
	
	//damage numbers
	scr_ui_damageNumbers(totalDam, env);
	
	return lost;
	
}

function scr_env_addContents(target, item) {
	
	//validate
	if (!instance_exists(target)) return false;
	if (!variable_instance_exists(target, "contents")) return false;
	if (!is_array(target.contents)) return false;
	
	//check if full
	if (variable_instance_exists(target, "maxContents")) {
	
		var contentsLen = array_length(target.contents);
		
		if (contentsLen >= target.maxContents) return false;
	
	}
	
	//add contents
	array_push(target.contents, item);
	
	return true;
	
}

function scr_env_addDrop(dest, obj, chance, maxVal) {

	var struct = {
	
		obj: obj,
		chance: chance,
		maxVal: maxVal
	
	}
	
	var success = scr_env_addContents(dest, struct);
	
	return success;
	
}