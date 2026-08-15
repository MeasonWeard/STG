event_inherited();

image_speed = -dir * (spd * 1.83);

var player = global.player;

if (instance_exists(player)) {

	if (point_in_rectangle(player.x, player.y, colLeft, colTop, colRight, colBottom)) {
	
		player.yspd += dir * spd;
	
	}
	
}
