event_inherited();

if (scr_timeSlicing_isMyTurn("findTarget", findTargetIndex)) {
	
	if (instance_exists(target)) {
	
		var dist = point_distance(x, y, target.x, target.y);
		if (dist > reTargetDist) target = noone;
	
	}
	
	if (!instance_exists(target)) target = scr_char_getNearestToSource(self, true);
	
}

if (instance_exists(target)) {

	scr_ai_shootAtTarget(self, target, true);
	
}