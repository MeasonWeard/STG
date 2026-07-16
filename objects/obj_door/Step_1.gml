if (!sc.hub and side == "top" and initialiseDoors) {

	initialiseDoors = false;

	var sprH = sprite_height;
	var sprW = sprite_width;

	//eliminate other doors first, in case I accidentally place more than one initial door
	with (obj_door) {
		
		if (id == other.id) continue;
		instance_destroy();
	
	}

	//place self at top
	y = 0;
	x = room_width * 0.5;

	//other doors

	//create bottom door
	if (scr_stages_isCellInDirValid("down")) {
		//show_debug_message("creating bottom door");
		var newX = room_width * 0.5;
		var newY = room_height + sprH;
		var newDoor = instance_create_layer(newX, newY, "Instances", object_index);
		newDoor.side = "bottom";
	}

	//create left door
	if (scr_stages_isCellInDirValid("left")) {
		//show_debug_message("creating left door");
		var newX = 0 - sprW * 0.5;
		var newY = (room_height * 0.5) + sprH * 0.5;
		var newDoor = instance_create_layer(newX, newY, "Instances", object_index);
		newDoor.side = "left";
	}

	//create right door
	if (scr_stages_isCellInDirValid("right")) {
		//show_debug_message("creating right door");
		var newX = room_width + sprW * 0.5;
		var newY = (room_height * 0.5) + sprH * 0.5;
		var newDoor = instance_create_layer(newX, newY, "Instances", object_index);
		newDoor.side = "right";
	}

	//delete self if no valid room up
	if (!scr_stages_isCellInDirValid("up")) instance_destroy();
	
}

//initialise area
if (initialiseArea) {

	initialiseArea = false;
	
	var sprW = sprite_width;
	var sprH = sprite_height;
	var halfW = sprW * 0.5;
	var halfH = sprH * 0.5;
	
	textX = x;
	textY = y - halfH;
	
	//get side
	var leftDist   = abs(x);
	var rightDist  = abs(x - room_width);
	var topDist    = abs(y);
	var bottomDist = abs(y - room_height);

	var closest = topDist;
	side = "top";

	if (bottomDist < closest ) {
		closest  = bottomDist;
		side = "bottom";
	}

	if (leftDist < closest ) {
		closest  = leftDist;
		side = "left";
	}

	if (rightDist < closest ) {
		closest  = rightDist;
		side = "right";
	}

	//set area
	if (side == "top") {
	
		areaTop = y - sprH;
		areaBottom = y + areaDist;
		areaLeft = x - halfW;
		areaRight = x + halfW;
		
	}
	
	if (side == "bottom") {
	
		areaTop = y - sprH - areaDist;
		areaBottom = y;
		areaLeft = x - halfW;
		areaRight = x + halfW;
	
	}
	
	if (side == "left") {
	
		areaTop = y - sprH;
		areaBottom = y;
		areaLeft = x - halfW;
		areaRight = x + halfW + areaDist;

	}
	
	if (side == "right") {
	
		areaTop = y - sprH;
		areaBottom = y;
		areaRight = x + halfW;
		areaLeft = x - halfW - areaDist;

	}
	
	yMid = (areaBottom + areaTop) * 0.5;
	xMid = (areaLeft + areaRight) * 0.5;
		
}