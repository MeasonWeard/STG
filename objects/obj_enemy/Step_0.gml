event_inherited();

if (instance_exists(target)) {

	var xx = target.x;
	var yy = target.y;
	
	scr_ai_moveTowardsPoint(xx, yy, walkSpeed);
	
}