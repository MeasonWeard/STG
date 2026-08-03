var prevFont = draw_get_font();
var prevCol = draw_get_colour();

draw_set_halign(hAlign);
draw_set_valign(vAlign);
draw_set_font(font);
draw_set_color(col);

var width = sprite_width * abs(image_xscale);
var height = sprite_height * abs(image_yscale);

var xx = x;
if (hAlign == fa_right) xx = x + width;
if (hAlign == fa_middle or hAlign == fa_center) xx = x + width * 0.5;
var yy = y;
if (vAlign == fa_bottom) yy = y + height;
if (vAlign == fa_middle or vAlign == fa_center) yy = y + height * 0.5;

draw_text(xx, yy, txt);

scr_misc_resetTextAlignment();
draw_set_font(prevFont);
draw_set_color(prevCol);