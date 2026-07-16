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

function scr_env_interactable(env, showDist, useDist, func, tag) {
	
	var player = global.player;
	
	if (!instance_exists(env)) exit;
	if (!instance_exists(player)) exit;
	
	var xx = player.x;
	var yy = player.y;
	
	var pad = 12;
	
	var left = env.colLeft;
	var right = env.colRight;
	var top = env.colTop;
	var bottom = env.colBottom;
	
	var closestX = clamp(xx, left, right);
	var closestY = clamp(yy, top, bottom);
	
	var dist = point_distance(xx, yy, closestX, closestY);
	
	var showInteraction = dist <= showDist;
	var canInteract = dist <= useDist;
	
	if (showInteraction) {
	
		var col = canInteract ? c_lime : #B2FFB2;
		var xMid = (left + right) * 0.5;

		draw_rectangle_colour(left - pad, top - pad, right + pad, bottom + pad, col, col, col, col, true);

		var txt = canInteract ? tag + ("   (F)") : tag;

		if (is_string(tag)) scr_ui_displayTag(xMid, top - 24, 100, txt, col);

	}
	
	if (canInteract) {
	
		if (keyboard_check_pressed(ord("F")) and is_callable(func)) func();
	
	}
	
}