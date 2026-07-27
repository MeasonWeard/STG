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
	
	if (keyboard_check_pressed(vk_delete)) {
   
		with (obj_enemy) {
			hp = 0;
		}
	
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

if (!hub) {
	
	//arrows
	var enemies = instance_number(obj_enemy);

	if (!createdArrows and enemies < 16) {

		createdArrows = true;
	
		with(obj_enemy) {
	
			var arrow = instance_create_layer(0, 0, "Instances", obj_arrow);
			arrow.target = self;
			arrow.source = global.player;
			arrow.col = c_red;
	
		}
	
	}

	if (enemies == 0 and stageInProgress) {

		stageInProgress = false;

		if (rc.currentCell.endCell == true) {
		
			global.runController.gameState = "win";
		
			var midX = (global.roomRight + global.roomLeft) * 0.5;
			var midY = (global.roomTop + global.roomBottom) * 0.5;

			scr_obj_createPortal(midX, midY);
		
		}

		with (obj_door) {
		
			open = true;
		
			var arrow = instance_create_layer(x, y, "Instances", obj_arrow);
			arrow.target = self;
			arrow.source = global.player;
			arrow.text = "EXIT";
			arrow.col = c_lime;
		
		}
		
		with (obj_destructible) {
			if (destroyWhenStageOver) instance_destroy();	
		}
		
		rc.currentCell.cleared = true;
	
	}

}