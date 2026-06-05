event_inherited();

centreX = x + gunXoffset;
centreY = y - gunYoffset;

if (gunCentred) {
	centreX = x;
	centreY = y;
}

var gunDir = point_direction(centreX, centreY, aimX, aimY);

gunX = centreX + lengthdir_x(gunDist, gunDir);
gunY = centreY + lengthdir_y(gunDist, gunDir);