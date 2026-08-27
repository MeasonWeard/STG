event_inherited();

if (movedThisStep) image_speed = 1;
else image_speed = 0;

//sprites
if (spawning) {
	
	sprite_index = sprites.spawn;
	image_speed = 1;
	
	if (image_index == image_number - 1) {
		sprite_index = sprites.down;
		image_speed = 0;
		spawning = false;
	}
	
}

draw_self();

//shield
if (shield > 0) {

	var pulse = sin(current_time * 0.005);
	var shieldScale = 1.08 + pulse * 0.04;
	var sprHeight = sprite_height;

	var yOffset = sprHeight * abs(image_yscale) * (shieldScale - 1) * 0.5;
	
	var shieldCol = shieldFlash > 0 ? #EDA5E7 : #ED008C;
	var shieldAlpha = shieldFlash > 0 ? 0.7 : 0.4 + pulse * 0.05;

	draw_sprite_ext(sprite_index, image_index, x, y + yOffset, image_xscale * shieldScale, image_yscale * shieldScale, image_angle, shieldCol, shieldAlpha);
	
}

if (damageFlash > 0) {

	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_red, image_alpha);
	
}

if (global.debug) {
	
	draw_sprite(spr_point, 0, gunX, gunY);
	draw_sprite(spr_point, 0, aimX, aimY);
	draw_sprite(spr_point2, 0, x, y);
	draw_sprite(spr_point2, 0, centreX, centreY);
	draw_text(x - 32, y + 32, string(hp) + "/" + string(maxHp));
	
	var prevCol = draw_get_colour();
	draw_set_colour(c_aqua);
	draw_rectangle(colLeft, colTop, colRight, colBottom, true);
	draw_set_colour(prevCol);
	
	draw_set_colour(c_yellow);
	//draw_text(x, y + 64, string(finalStats.da));
	
	draw_text(x, y, string(nearbyEnv));
	
	//draw_sprite(spr_cursor1, 0, xstart, ystart);
	//draw_text(x, y, string(x) + "," + string(y));
	//draw_text(x, y, string(hashCellX) + "," + string(hashCellY));
	
}

step++;