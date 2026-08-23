if (!instance_exists(owner)) {
	instance_destroy();
	exit;
}

if (!active) exit;

if (useAim) {
	
	x = owner.aimX;
	y = owner.aimY;

} else {

	x = owner.x;
	y = owner.y;

}

if (timer > 0) {
	timer--;
}