var playerinArea = false;

if (instance_exists(player)) {
	
	playerinArea = player.x >= areaLeft and player.x <= areaRight and player.y >= areaTop and player.y <= areaBottom;
	
}

if (playerinArea) {
	scr_ui_displayInstructions("Press E to proceed", 0);
}