if (instance_exists(owner)) {

	x = owner.x;
	y = owner.y - owner.sprite_height * 0.45;
	
} else {

	instance_destroy();
	
}

if (life > 0) {

	life --;
	
} else {

	instance_destroy();
	
}