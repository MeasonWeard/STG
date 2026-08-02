depth = -y;

if (die) {

	image_alpha -= 0.03;
	
	if (image_alpha < 0.02) instance_destroy();
	
}

