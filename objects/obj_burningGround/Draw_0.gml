// Inherit the parent event
event_inherited();

if (damage.chem > 0) {

	var radius = sprite_width * 0.5;
	draw_circle_colour(x, y, radius, c_green, c_green, true);
	
}