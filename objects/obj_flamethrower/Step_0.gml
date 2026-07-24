if (instance_exists(owner)) {

	x = owner.x;
	y = owner.y + yOffset;
	
}

orbitAngle += orbitSpd;

if (lifeTick > 0) {

	lifeTick--;
	
} else {

	instance_destroy();
	
}