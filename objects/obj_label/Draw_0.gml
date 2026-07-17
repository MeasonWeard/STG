var prevFont = draw_get_font();
var prevCol = draw_get_colour();

draw_set_halign(hAlign);
draw_set_valign(vAlign);
draw_set_font(font);
draw_set_color(col);

var xx = x;
if (hAlign == fa_right) xx = x + sprite_width;
if (hAlign == fa_middle or hAlign == fa_center) xx = x + sprite_width * 0.5;
var yy = y;
if (vAlign == fa_top) xx = y + sprite_height;
if (vAlign == fa_middle or vAlign == fa_center) yy = y + sprite_height * 0.5;

draw_text(xx, yy, txt);

scr_misc_resetTextAlignment();
draw_set_font(prevFont);
draw_set_color(prevCol);
