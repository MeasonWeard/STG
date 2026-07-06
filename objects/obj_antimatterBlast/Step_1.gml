if (setup) {

	setup = false;
	
	var changeFactor = max(projectiles - 8, 0);
	
	shootDelay = max(4 - changeFactor * 0.1, 1);
	
	spinSpeed = 11 + changeFactor * 0.8;
	
}