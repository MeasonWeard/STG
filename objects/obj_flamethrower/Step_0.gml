if (instance_exists(owner) and owner.active) {

	x = owner.x;
	y = owner.y + yOffset;
	audio_emitter_position(emitter, x, y, 0);
	
} else {

	instance_destroy();
	
}

orbitAngle += orbitSpd;

if (lifeTick > 0) {

	lifeTick--;
	
} else {

	instance_destroy();
	
}