event_inherited();

if (spawning) exit;
	
if (scr_timeSlicing_isMyTurn("findTarget", findTargetIndex)) {
	
	if (instance_exists(target)) {
	
		var dist = point_distance(x, y, target.x, target.y);
		if (dist > reTargetDist) target = noone;
	
	}
	
	if (!instance_exists(target)) target = scr_char_getNearestToSource(self, true);
	
}

scr_ai_shootAtTarget(self, target, true);