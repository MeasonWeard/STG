scripted = true;

scriptFunc = function() {

	if (!variable_instance_exists(self, "trainSetup")) {
	
		trainSetup = false;
		
		trainSpeed = 2;
		trainDecal = 0.001;
	
	}
	
	if (trainSpeed > 0) {
		trainSpeed -= trainDecal;
	} else {
		trainSpeed = 0;
		scr_stages_completeStage();
	}
	
	if (trainSpeed <= 1) trainDecal = 0.01;

	with(obj_trainWindow) {
	
		image_speed = other.trainSpeed;
	
	}

	
}