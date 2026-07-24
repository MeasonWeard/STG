xspd = lengthdir_x(spd, dir);
yspd = lengthdir_y(spd, dir);

var nextX = x + xspd;
var nextY = y + yspd;

if (rot == 0) {
	image_angle = dir;
} else {
	image_angle += rot;
}

x = nextX;
y = nextY;

if (smashTick > 0) {
	
	smashTick --;	
	
} else {

	instance_destroy();
	var snd = scr_audio_randomSoundFromProfile(global.data.soundProfiles.bottleBreak);
	scr_audio_playSoundAt(snd, x, y);
	
	var pool = instance_create_layer(x, y, "Instances", obj_acidPool);
	pool.life = poolLife;
	pool.radius = radius;
	pool.damage = damage;
	pool.faction = faction;
	pool.xSide = choose(1, -1);
	pool.ySide = choose(1, -1);
	
}