var extra = 10 * sin(current_time * pi / 1000);

var rad = radius + extra;

if (newTick > 0) {
	
	newTick --;
	alpha += 0.4 / 16;
	
} else {
	
	alpha = 0.4;
	if (life < 60) alpha = 0.4 * (life / 60);
	
}


draw_set_alpha(alpha);
draw_circle_colour(x, y, rad, c_navy, c_purple, false);
draw_set_alpha(1);