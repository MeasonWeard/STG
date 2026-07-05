if (image_xscale < 1) {

	image_xscale += 0.04;
	image_yscale += 0.04;
	
	if (image_xscale > 1) {
		image_xscale = 1;
		image_yscale = 1;
	}
	
}

image_alpha += alphaDir * 0.01;

if (image_alpha >= 0.7) alphaDir = -1;
if (image_alpha <= 0.5) alphaDir = 1;

if (instance_exists(player)) {

	playerInArea = player.x > areaLeft and player.x < areaRight and player.y > areaTop and player.y < areaBottom;
	
}

if (playerInArea) {
	
	scr_ui_displayInstructions("Press E to end run", 0);
	
	if (keyboard_check_pressed(ord("E"))) room_goto(room_endRun);
	
}