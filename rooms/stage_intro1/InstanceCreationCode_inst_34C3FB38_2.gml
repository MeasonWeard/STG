scripted = true;
txt = "WASD = move\nSpace = dash";

scriptFunc = function() {


	if (!variable_instance_exists(self, "trainSetup")) {
	
		trainSetup = false;
		
		trainSpeed = 2;
		trainDecal = 0.001;
		
		movePlayerStart = true;
		
		alarmLighting = noone;
		
		scr_ui_displayInstructions(txt, 22);
	
	}
	
	if (instance_exists(player) and movePlayerStart) {
	
		movePlayerStart = false;
		scr_movement_teleport(player, room_width * 0.5 - 128, room_height * 0.5 - 120);
	
	}
	
	if (trainSpeed > 0) {
		trainSpeed -= trainDecal;
	} else {
		trainSpeed = 0;
		scr_stages_completeStage();
	}
	
	if (trainSpeed <= 1) {
		
		trainDecal = 0.01;
		
		if (alarmLighting == noone) {
			alarmLighting =  instance_create_layer(x, y, "Instances", obj_alarmLighting);
			scr_audio_setAmbience(1, snd_alarm1, true);
		}
		
	}

	with(obj_trainWindow) {
	
		image_speed = other.trainSpeed;
	
	}

	
}