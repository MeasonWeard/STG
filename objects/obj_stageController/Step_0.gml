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


// time slicing index update
var sliceKeys = variable_struct_get_names(timeSlicing);
var sliceKeysLen = array_length(sliceKeys);

for (var i = 0; i < sliceKeysLen; i++) {

	var key = sliceKeys[i];
	var slice = timeSlicing[$ key];

	slice.turn++;
	if (slice.turn >= slice.steps) slice.turn = 0;
	
}