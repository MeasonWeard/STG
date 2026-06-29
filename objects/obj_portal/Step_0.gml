if (image_xscale < 1) {

	image_xscale += 0.05;
	image_yscale += 0.05;
	
}

if (instance_exists(player)) {

	playerInArea = player.x > areaLeft and player.x < areaRight and player.y > areaTop and player.y < areaBottom;
	
}