function scr_ai_moveTowardsPoint(targetX, targetY, moveSpd) {

	var dir = point_direction(x, y, targetX, targetY);

	xspd = lengthdir_x(moveSpd, dir);
	yspd = lengthdir_y(moveSpd, dir);

}