if (!instance_exists(owner)) exit;
if (array_length(lines) <= 0) exit;


var text = lines[lineIndex];

// determine where owner's world position is on screen
var xx = owner.x;
var yy = owner.y - yOff;

yy -= 80;

draw_set_halign(fa_middle);
draw_set_valign(fa_middle);
draw_set_font(fnt_normal);
draw_set_colour(c_white);


draw_text(xx, yy, text);

draw_set_colour(c_lime);

draw_text(xx + 1, yy + 1, text);