if (pullSpd > 0) {

    var dir = point_direction(x, y, pullX, pullY);

    x += lengthdir_x(pullSpd, dir);
    y += lengthdir_y(pullSpd, dir);

    pullSpd = 0;
	
}

if (burstVel > 0) {
	
    x += lengthdir_x(burstVel, burstDir);
    y += lengthdir_y(burstVel, burstDir);

    burstVel --;
	
}