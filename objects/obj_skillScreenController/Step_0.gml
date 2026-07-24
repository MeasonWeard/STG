if (global.devControls) {
	
	if (keyboard_check_pressed(vk_subtract)) global.debug = !global.debug;
	if (keyboard_check_pressed(ord("T"))) room_goto(room_testSkills);
	
}