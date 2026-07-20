if (hub and instance_exists(global.player)) {
	
	global.hubPosX = global.player.x;
	global.hubPosY = global.player.y;
	
}

if (!instance_exists(global.player)) {

	deathCountdown--;
	
	if (deathCountdown < 1) scr_stages_endRun();
	
}