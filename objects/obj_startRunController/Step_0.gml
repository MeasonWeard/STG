//dev controls
if (global.devControls) {

	if (keyboard_check_pressed(vk_home)) {
   
		scr_display_switchFullscreen();
	
	}

	if (keyboard_check_pressed(vk_end)) {
   
		scr_display_cycleResolution();
	
	}

	if (keyboard_check_pressed(vk_enter)) {
   
		room_goto(room_startRunTest);
	
	}



	
}

//controls
if (keyboard_check_pressed(vk_escape)) {
   
	room_goto(stage_hub1);
	
}

	if (keyboard_check_pressed(vk_space)) {
	
		if (instance_exists(rc)) scr_stages_goToStage(rc.currentCell);
	
	}