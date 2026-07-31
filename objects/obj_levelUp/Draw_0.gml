radius += 2;

var spacing = 10;
var maxRings = 18;

var totalRings = radius div spacing;
var overflow = max(0, totalRings - maxRings);

// Increase to maxRings, then decrease by one per overflow
var ringsToDraw = min(totalRings, maxRings) - overflow;
ringsToDraw = max(0, ringsToDraw);

if (radius > 120) innerAlpha -= 0.01;

draw_set_alpha(innerAlpha);
draw_circle_colour(x, y, radius, c_white, c_fuchsia, false);

draw_set_alpha(1);
draw_set_colour(c_white);

// i = 0 is the outermost ring
for (var i = 0; i < ringsToDraw; i++) {

	var ringRad = radius - i * spacing;
	draw_circle(x, y, ringRad, true);

}

if (ringsToDraw == 0) {
	instance_destroy();
}

if (drawText) {

	txtYOff -= 1;

	draw_set_halign(fa_middle);
	draw_set_font(fnt_huge);
	draw_set_colour(c_lime);
	draw_text(x, y + txtYOff, "LEVEL UP!");
	
}