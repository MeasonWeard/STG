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

if (setMaxCharges) {

	setMaxCharges = false;
	if (is_instanceof(skills.skill1, skill)) {
		skills.skill1.charges = skills.skill1.maxCharges;
		skills.skill1.cooldown = 0;
	}
	if (is_instanceof(skills.skill2, skill)) {
		skills.skill2.charges = skills.skill2.maxCharges;
		skills.skill2.cooldown = 0;
	}
	if (is_instanceof(skills.skill3, skill)) {
		skills.skill3.charges = skills.skill3.maxCharges;
		skills.skill3.cooldown = 0;
	}
	if (is_instanceof(skills.skill4, skill)) {
		skills.skill4.charges = skills.skill4.maxCharges;
		skills.skill4.cooldown = 0;
	}
	
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