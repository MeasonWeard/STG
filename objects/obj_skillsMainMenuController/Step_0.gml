if (global.devControls) {
	
	if (keyboard_check_pressed(ord("T"))) {
		room_goto(room_testSkills);
		global.selectedClass = playerData.class1;
	}
	
	if (keyboard_check_pressed(ord("P"))) {
		room_goto(room_physics);
		global.selectedClass = playerData.class1;
	}
	
	if (keyboard_check_pressed(ord("C"))) {
		room_goto(room_chemistry);
		global.selectedClass = playerData.class1;
	}
	
	if (keyboard_check_pressed(ord("B"))) {
		room_goto(room_biology);
		global.selectedClass = playerData.class1;
	}
	
	if (keyboard_check_pressed(ord("E"))) {
		room_goto(room_engineering);
		global.selectedClass = playerData.class1;
	}
	
}