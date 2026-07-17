var prevFont = draw_get_font();
var prevCol = draw_get_colour();

draw_set_halign(hAlign);
draw_set_valign(vAlign);
draw_set_font(font);
draw_set_color(col);

draw_text(x, y, txt);

scr_misc_resetTextAlignment();
draw_set_font(prevFont);
draw_set_color(prevCol);
