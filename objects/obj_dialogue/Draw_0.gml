if (!active) exit;

if (!instance_exists(owner)) exit;
if (array_length(lines) <= 0) exit;

var text = lines[lineIndex];

draw_set_colour(c_blue);
draw_set_alpha(0.25);

draw_rectangle(left, top, right, bottom, false);

draw_set_colour(c_black);
draw_set_alpha(1);

draw_rectangle(left, top, right, bottom, true);

draw_set_halign(fa_middle);
draw_set_valign(fa_middle);
draw_set_font(fnt_normal);
draw_set_colour(c_white);
draw_set_alpha(0.5);

draw_text(textX - 1, textY - 1, text);

draw_set_alpha(1);
draw_set_colour(c_lime);

draw_text(textX, textY, text);