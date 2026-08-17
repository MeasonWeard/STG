event_inherited();

var canBeAlerted = true;

if (runBack) {

	canBeAlerted = false;

	if (hurt) {
		runBack = false;
		alert = true;
	}

	if (runBack) {

		//tp back
		if (scr_timeSlicing_isMyTurn("offScreen", offScreenIndex)) {
			
			var off = scr_obj_offScreen(self, 64);
			
			if (off) {
				
				scr_movement_teleport(self, xstart, ystart);
				xspd = 0;
				yspd = 0;
				
			}
			
		}
		
		//return
		var distFromStart = point_distance(x, y, xstart, ystart);
		
		if (distFromStart > spd * 1.5) {
			
			scr_ai_moveTowardsPointAvoid(xstart, ystart, spd, avoidDist);
			
		} else {

			scr_movement_teleport(self, xstart, ystart);
			xspd = 0;
			yspd = 0;
			runBack = false;
			hurt = false;
			canBeAlerted = true;
			
		}
		
		//can be alerted
		if (sc.alertEnemies <= ALERT_ENEMIES_IDEAL) {
			canBeAlerted = true;
		}
		
	}
	
}

//detection
if (!alert and canBeAlerted) {

	if (instance_exists(target) and scr_timeSlicing_isMyTurn("detection", detectionIndex) and sc.alertDelay <= 0) {
	
		var dist = point_distance(x, y, target.x, target.y);
		var seen = false;
		
		if (dist <= detectionDist) {
			seen = scr_physics_hasLineOfSight(x, y, target.x, target.y);
		}
		
		if (seen or hurt) {
			
			alert = true;
			if (alertAllies) scr_ai_alertAllies(self, detectionDist * 0.5);
			
		}
	
	}
	
}

if (alert) {
	
	runBack = false;
	
	scr_ai_standardAIBehaviour();

	if (sc.alertEnemies > ALERT_ENEMIES_IDEAL) {
	
		var distFromStart = point_distance(x, y, xstart, ystart);
		if (distFromStart > ENEMY_CHASE_RANGE) {
			runBack = true;
			alert = false;
			hurt = false;
			scr_ai_moveGhost(self, xstart, ystart);
		}
	
	
	}

}

