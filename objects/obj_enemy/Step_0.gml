event_inherited();

//first destination pick
if (firstGhostCheck) {

	firstGhostCheck = false;
	
	var pt = scr_ai_choosePointAroundTarget(target, targetMinDist, targetMaxDist, true);

}

//periodically check if destination is still okay
if (scr_timeSlicing_isMyTurn("ghostCheck", ghostCheckIndex)) {

	var col = scr_ai_ghostOverlap(self);
	var tooFar = false;
	
	if (instance_exists(target)) {
		tooFar = point_distance(ghost.x, ghost.y, target.x, target.y) > targetReaquireDist;
	}
	
	if (col or tooFar) {
		
		var pt = scr_ai_choosePointAroundTarget(target, targetMinDist, targetMaxDist, true);
				
	}

}


//move toward ghost
if (instance_exists(target)) {

	scr_ai_moveTowardsPoint(ghost.x, ghost.y, walkSpeed);
	scr_ai_shootAtTarget(self, target, aimOnReload);

} else {

	xspd = 0;
	yspd = 0;

}