if (instance_exists(target)) {

	var desiredLookAheadX = 0;
	var desiredLookAheadY = 0;

	//mouse look
	var margin = 32;

	var point = scr_ui_convertToScreenSpace(cursor.x, cursor.y);
	var mx = point.xx;
	var my = point.yy;
	
	var vy = view_yport[0];
	var vh = view_hport[0];
	var vx = view_xport[0];
	var vw = view_wport[0];
	
	var nearTop = (my <= vy + margin);
	var nearBottom = (my >= vy + vh - margin);
	var nearLeft  = (mx <= vx + margin);
	var nearRight = (mx >= vx + vw - margin);
	
	if (nearTop) desiredLookAheadY = -lookAheadDistanceByMouse;
	if (nearBottom) desiredLookAheadY = lookAheadDistanceByMouse;
	if (nearLeft)  desiredLookAheadX = -lookAheadDistanceByMouse;
	if (nearRight) desiredLookAheadX =  lookAheadDistanceByMouse;

	if (desiredLookAheadX != 0) {
		lookAheadX += (desiredLookAheadX - lookAheadX) * lookAheadSpeed;
	} else {
		lookAheadX += (0 - lookAheadX) * lookAheadReturn;
	}

	if (desiredLookAheadY != 0) {
		lookAheadY += (desiredLookAheadY - lookAheadY) * lookAheadSpeedY;
	} else {
		lookAheadY += (0 - lookAheadY) * lookAheadReturnY;
	}

	targetX = target.x + lookAheadX;
	targetY = target.y + lookAheadY;

	var dx = targetX - x;
	var dy = targetY - y;

	var xFactor = clamp(follow + abs(dx) * catchUp, 0, maxFollow);
	var yFactor = clamp(follow + abs(dy) * catchUp, 0, maxFollow);

	x += dx * xFactor;
	y += dy * yFactor;

}