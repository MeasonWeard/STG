function scr_movement() {

	var moveX = xspd;
	var moveY = yspd;

	var prevX = x;
	var prevY = y;
	
	movedThisStep = false;

	// Correct diagonal movement
	if (moveX != 0 and moveY != 0) {
	
		var factor = 0.70710678; // 1 / sqrt(2)
		
		moveX *= factor;
		moveY *= factor;
	
	}


	
	if (confineToBounds) {
		
		x = clamp(x + moveX, global.roomLeft, global.roomRight);
		y = clamp(y + moveY, global.roomTop, global.roomBottom);
		
	} else {
		
		x += moveX;
		y += moveY;
		
	}
	
	if (x != prevX or y != prevY) movedThisStep = true;

}