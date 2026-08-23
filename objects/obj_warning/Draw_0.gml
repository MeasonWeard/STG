if (!active) exit;

draw_set_alpha(0.25);
draw_set_colour(c_red);

draw_circle(x, y, radius, false);

draw_set_alpha(1);
draw_set_colour(c_red);

draw_circle(x, y, radius, true);

draw_set_alpha(1);
draw_set_colour(c_white);