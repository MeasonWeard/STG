event_inherited();

sc = global.stageController;

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