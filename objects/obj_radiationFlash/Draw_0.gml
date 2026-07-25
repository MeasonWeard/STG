draw_set_colour(c_purple);
draw_set_alpha(alpha);
draw_circle(x, y, radius, false);
draw_set_alpha(1);

alpha -= 0.02;

if (alpha <= 0) instance_destroy();