if (global.devControls) {

	if (keyboard_check_pressed(vk_home)) {
   
		scr_display_switchFullscreen();
	
	}

	if (keyboard_check_pressed(vk_end)) {
   
		scr_display_cycleResolution();
	
	}

	if (keyboard_check_pressed(vk_enter)) {
   
		room_restart();
	
	}

	if (keyboard_check_pressed(vk_escape)) {
   
		game_end();
	
	}
	
	if (keyboard_check_pressed(vk_subtract)) {
   
		global.debug = !global.debug;
	
	}

}
