var radius = 80;
var innerCount = 5;

//background bubble
draw_set_colour(c_blue);
draw_set_alpha(0.15);

draw_circle(x, y, radius, false);

//moving concentric circles
draw_set_alpha(0.5);

var cycle = (current_time * 0.0005) mod 1;

for (var i = 0; i < innerCount; i++) {

	var t = (cycle + i / innerCount) mod 1;
	var r = radius * t;

	draw_circle(x, y, r, true);

}

draw_set_alpha(1);
draw_set_colour(c_white);