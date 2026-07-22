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

if (instance_exists(target)) {

	var reaim = scr_randomIntermittent(12, 45);

	if (reaim) {

		scr_ai_aimAtTarget(self, target, aimAngle, aimBias);
	
	}
	
}
	
if (aimX < x) image_xscale = 1;
if (aimX > x) image_xscale = -1;

if (equippedWeapon.reload > 0 and !newClip) {

	newClip = true;
	clips --;
	
}

if (equippedWeapon.reload == 0 and newClip) {

	newClip = false;
	
}

if (clips <= 0) hp = 0;