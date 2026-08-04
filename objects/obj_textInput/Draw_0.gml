var fnt = font ?? fnt_normal;

var mid = y + height * 0.5;

draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_set_font(font);

draw_set_colour(bgCol);
draw_rectangle(x, y, x + width, y + height, false);

draw_set_colour(borderCol);
draw_rectangle(x, y, x + width, y + height, true);

draw_set_colour(textCol);
draw_text(x + pad, mid, text);