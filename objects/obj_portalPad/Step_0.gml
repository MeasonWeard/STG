event_inherited();

if (powerDown) {

	if (powerDownDelay > 0) {
	
		powerDownDelay--;
		image_speed = 0;
		image_index = 0;
	
	} else {
	
		image_speed = 1;
		
		if (image_index == image_number - 1) {
			image_speed = 0;
			powerDown = false;
			powerDownDelay = 42;
		}
		
	}
	
}

