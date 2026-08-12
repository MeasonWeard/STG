if (pullSpd > 0) {

    var dir = point_direction(x, y, pullX, pullY);

    x += lengthdir_x(pullSpd, dir);
    y += lengthdir_y(pullSpd, dir);

	var dist = point_distance(x, y, pullX, pullY);
	
    if (dist <= pullSpd) {
		pullSpd = 0;
		x = pullX
		y = pullY;
	}
	
	if (instance_exists(player)) {
		
		dist = point_distance(x, y, player.x, player.y)
		
		if (dist <= COLLECTION_RANGE) {
	
			scr_items_collect(player, self);
	
		}
		
	}
	
}

if (burstVel > 0) {
	
    x += lengthdir_x(burstVel, burstDir);
    y += lengthdir_y(burstVel, burstDir);

    burstVel --;
	
}