var playerinArea = false;

if (instance_exists(player)) {
	
	playerinArea = player.x >= areaLeft and player.x <= areaRight and player.y >= areaTop and player.y <= areaBottom;
	
}

if (playerinArea and open) {
	
	scr_ui_displayInstructions("Press E to proceed", 0);
	
	var dir = undefined;
	var moveX = 0;
	var moveY = 0;
	
	if (side == "top") {
		dir = 0;
		moveX = x;
		moveY = global.roomBottom;
	}
	
	if (side == "right") {
		dir = 1;
		moveX = global.roomLeft;
		moveY = room_height * 0.5;
	}
	
	if (side == "bottom") {
		dir = 2;
		moveX = x;
		moveY = global.roomTop;
	}
	
	if (side == "left") {
		dir = 3;
		moveX = global.roomRight;
		moveY = room_height * 0.5;
	}
	
	if (keyboard_check_pressed(ord("E"))) {
		
		var moved = scr_stages_moveInDir(dir);
		
		if (moved) {
			player.x = moveX;
			player.y = moveY;
		}
		
	}
	
}