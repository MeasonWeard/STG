event_inherited();

sc = global.stageController;

if (!dashing) {
	
	xspd = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * finalStats.spd;
	yspd = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * finalStats.spd;

}

if (keyboard_check_pressed(vk_space)) scr_movement_dash(self);