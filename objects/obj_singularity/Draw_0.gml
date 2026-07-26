draw_set_colour(c_black);
draw_circle(x, y, size, false);

size += sizeDir * 0.25;

if (size >= 28) sizeDir = -1;
if (size <= 22) sizeDir = 1;