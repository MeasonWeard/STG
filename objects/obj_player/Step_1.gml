event_inherited();

sc = global.stageController;

if (is_string(moveToSide) and !sc.hub and sc.checkPlayerMoveToSide) {

	var centreX = room_width * 0.5;
	var centreY = room_height * 0.5;
	
	var in = 5;
	
	x = centreX;
	y = centreY;
	
	if (moveToSide == "top") y = in;
	if (moveToSide == "bottom") y = room_height - in;
	if (moveToSide == "left") x = in;
	if (moveToSide == "right") x = room_width - in;
		
	moveToSide = undefined;
	sc.checkPlayerMoveToSide = false;
	
}

if (!dashing) {
	
	var finalSpd = finalStats.spd;
	
	if (shootingTick > 0) {
		shootingTick --;	
		finalSpd = finalStats.spd * 0.6;
	}
	
	xspd = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * finalSpd;
	yspd = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * finalSpd;

}

if (keyboard_check_pressed(vk_space)) scr_movement_dash(self);