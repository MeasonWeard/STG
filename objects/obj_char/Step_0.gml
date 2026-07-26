event_inherited();

//ATTACK

centreX = x + gunXoffset;
centreY = y + gunYoffset;

if (gunCentred) {
	centreX = x;
	centreY = y;
}

var gunDir = point_direction(centreX, centreY, aimX, aimY);

gunX = centreX + lengthdir_x(gunDist, gunDir);
gunY = centreY + lengthdir_y(gunDist, gunDir);

//MOVEMENT

//speed
spd = finalStats.spd;

//dash
if (dash > 0) {

    var t = dash / dashTime;

    var dashSpd = spd * lerp(1, dashMult, t);

    xspd = dashX * dashSpd;
    yspd = dashY * dashSpd;

    dash = max(0, dash - 1);

    dashing = (dashSpd > spd * 1.25);

} else {
	
    dashing = false;
	
}

if (dashes < finalStats.maxDashes) {
	
	dashRecharge += finalStats.dashRegen / 60;

	if (dashRecharge >= 1) {

		dashRecharge--;

		dashes = min(finalStats.maxDashes, dashes + 1);

		if (dashes == finalStats.maxDashes) {
			dashRecharge = 0;
		}

	}
	
} else {

	dashRecharge = 0;
	
}

//if (dashCool > 0) {

//	dashCool --;
	
//} else {

//	dashes = min(finalStats.maxDashes, dashes + 1);
//	if (dashes < finalStats.maxDashes) dashCool = finalStats.dashCoolTime * 60;
	
//}