playerinArea = false;

if (instance_exists(player)) {
	
	//open when near if in hub
	if (sc.hub) {
	
		var dist = point_distance(player.x, player.y, xMid, yMid);
		open = dist <= openDist;
		displayTag = !open and dist <= displayTagDist;
	
	}

	
	//check if player is in activation area
	if (open) {
		
		playerinArea = player.x >= areaLeft and player.x <= areaRight and player.y >= areaTop and player.y <= areaBottom;
		
	}
	
}


if (playerinArea) {
	
	scr_ui_displayInstructions("Press F to proceed", 0);
	
	if (keyboard_check_pressed(ord("F"))) {
		
		//in game behaviour
		if (!sc.hub) {
		
			var dir = undefined;
			var moveSide = "";
			//var moveX = 0;
			//var moveY = 0;
	
			if (side == "top") {
				dir = 0;
				moveSide = "bottom";
				//moveX = x;
				//moveY = global.roomBottom;
				//player.moveToSide = "bottom";
			}
	
			if (side == "right") {
				dir = 1;
				moveSide = "left";
				//moveX = global.roomLeft;
				//moveY = room_height * 0.5;
				//player.moveToSide = "left";
			}
	
			if (side == "bottom") {
				dir = 2;
				moveSide = "top";
				//moveX = x;
				//moveY = global.roomTop;
				//player.moveToSide = "top";
			}
	
			if (side == "left") {
				dir = 3;
				moveSide = "right";
				//moveX = global.roomRight;
				//moveY = room_height * 0.5;
				//player.moveToSide = "right";
			}
		
			scr_items_collectAll();
		
			var moved = scr_stages_moveInDir(dir);
		
			if (moved) {
				player.moveToSide = moveSide;
				//player.x = moveX;
				//player.y = moveY;
			}
		
		} else {
		
			if (zoneConstructor != undefined) {
				global.selectedZone = zoneConstructor;
				room_goto(room_startRun);
			}
		
		}
		
	}
	
}