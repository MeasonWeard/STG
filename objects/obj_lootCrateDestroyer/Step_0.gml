if (!instance_exists(player)) exit;

if (destroyIndex >= cratesLen) {
	instance_destroy();
	exit;
}

x = player.x;
y = player.y;

var len = array_length(crates);

var radius = 180;

ringDir += spinSpd;

if (pulse >= 1.2) pulseDir = -1;
if (pulse <= 0.8) pulseDir = 1;

pulse += pulseDir * 0.025;

for (var i = 0; i < len; i++) {

	var crate = crates[i];
	if (!instance_exists(crate)) continue;

	crate.depth = layers.effects;
	crate.image_xscale = pulse;
	crate.image_yscale = pulse;

	var dir = ringDir + (360 / len) * i;

	var destX = x + lengthdir_x(radius, dir);
	var destY = y + lengthdir_y(radius, dir);

	var dist = point_distance(crate.x, crate.y, destX, destY);

	if (dist <= moveSpd) {

		crate.x = destX;
		crate.y = destY;

	} else {

		var moveDir = point_direction(crate.x, crate.y, destX, destY);

		crate.x += lengthdir_x(moveSpd, moveDir);
		crate.y += lengthdir_y(moveSpd, moveDir);

	}

}



if (countDown > 0) {

	countDown --;
	
} else {


	if (destroyTick > 0) {
		
		destroyTick --;	
		
	} else {
	
		destroyTick = 12;
		
		var crate = crates[destroyIndex];
		
		if (instance_exists(crate)) instance_destroy(crate);
		
		destroyIndex ++;
	
	}
	
}