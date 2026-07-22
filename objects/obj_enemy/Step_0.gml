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
	
	scr_ai_standardAIBehaviour();
	
}