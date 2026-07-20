event_inherited();

//detection
if (!alert) {

	var alertAllies = false;

	if (instance_exists(target) and scr_timeSlicing_isMyTurn("detection", detectionIndex)) {
	
		var dist = point_distance(x, y, target.x, target.y);
		var seen = false;
		
		if (dist <= detectionDist) {
			seen = scr_physics_hasLineOfSight(x, y, target.x, target.y);
		}
		
		if (seen or hurt) {
			
			alert = true;
			scr_ai_alertAllies(self, detectionDist * 0.5);
			
		}
	
	}
	
}

if (alert) {
	
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

		scr_ai_moveTowardsPointAvoid(ghost.x, ghost.y, spd, avoidDist);
		scr_ai_attackTarget(self, target, aimOnReload);
		//scr_ai_shootAtTarget(self, target, aimOnReload);

	} else {

		xspd = 0;
		yspd = 0;

	}

}