event_inherited();

if (destroyNextStep) instance_destroy();

if (image_index == image_number - 1) {
	image_speed = 0;
	destroyNextStep = disappear;
}