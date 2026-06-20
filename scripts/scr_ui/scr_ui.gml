function scr_ui_convertToScreenSpace(xx, yy) {
	
	var cam = view_camera[0];

	// Camera view
	var camX = camera_get_view_x(cam);
	var camY = camera_get_view_y(cam);
	var camW = camera_get_view_width(cam);
	var camH = camera_get_view_height(cam);

	// Viewport
	var vx = view_xport[0];
	var vy = view_yport[0];
	var vw = view_wport[0];
	var vh = view_hport[0];

	// Normalize camera (0–1 range)
	var nx = (xx - camX) / camW;
	var ny = (yy - camY) / camH;

	// Clamp so off-screen values don’t break edge checks
	nx = clamp(nx, 0, 1);
	ny = clamp(ny, 0, 1);

	// Convert to screen space
	var sx = vx + nx * vw;
	var sy = vy + ny * vh;

	return {
		xx: sx,
		yy: sy
	}
	
}

function scr_ui_drawMiniMap(miniMap, cellSize, xx, yy, flashX, flashY) {

	var mapW = array_length(miniMap);
	if (mapW <= 0) return;

	var mapH = array_length(miniMap[0]);

	var flash = is_real(flashX) and is_real(flashY) and flashX >= 0 and flashX < mapW
	and flashY >= 0 and flashY < mapH and ((current_time div 500) mod 2 == 0);

	for (var mx = 0; mx < mapW; mx++) {

		for (var my = 0; my < mapH; my++) {

			var col = miniMap[mx][my];

			if (flash and mx == flashX and my == flashY) {
				col = c_white;
			}

			var left   = xx + (mx * cellSize);
			var top    = yy + (my * cellSize);
			var right  = left + cellSize;
			var bottom = top + cellSize;

			// Fill
			draw_set_colour(col);
			draw_rectangle(left, top, right, bottom, false);

			// Border
			draw_set_colour(c_white);
			draw_rectangle(left, top, right, bottom, true);

		}

	}

	draw_set_colour(c_white);

}

function scr_ui_displayInstructions(text, extraTime) {

	var extraTick = extraTime * 60;

	if (extraTick == 0) extraTick = 2;

	var hud = global.hud;

	if (hud.instructions != text) hud.instructionsFlash = 120;

	hud.instructions = text;
	hud.instructionsTick = extraTick;
	
}

function scr_ui_skillIconFromData(xx, yy, align, sprite, name, key, charges, cooldown) {

	var left = xx;
	var top = yy;
	
	if (!sprite_exists(sprite)) sprite = spr_icon_blank;
	
	var size = sprite_get_width(sprite);

	switch (align) {
		case 1: // top right
			left = xx - size;
			break;

		case 2: // bottom right
			left = xx - size;
			top = yy - size;
			break;

		case 3: // bottom left
			top = yy - size;
			break;
	}

	var right = left + size;
	var bottom = top + size;

	cooldown = clamp(cooldown, 0, 1);

	//background
	draw_set_alpha(1);
	draw_set_colour(c_black);
	draw_rectangle(left, top, right, bottom, false);

	//sprite
	draw_sprite(sprite, 0, left, top);

	//cooldown overlay
	if (cooldown > 0) {
		
		var cdHeight = size * cooldown;

		draw_set_alpha(0.55);
		draw_set_colour(c_gray);
		draw_rectangle(left, bottom - cdHeight, right, bottom, false);
		draw_set_alpha(1);
		
	}

	//border
	draw_set_colour(c_white);
	draw_rectangle(left, top, right, bottom, true);
	
	//key, top left
	draw_set_colour(c_aqua);
	if (!is_undefined(key)) {
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_text(left + 3, top + 2, string(key));
	}

	//charges, top right
	if (!is_undefined(charges)) {
		draw_set_halign(fa_right);
		draw_set_valign(fa_top);
		draw_text(right - 3, top + 2, string(charges));
	}

	//reset
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(1);
	
}

function scr_ui_skillIcon(xx, yy, align, key, skill) {

	var sprite = undefined;
	var charges = undefined;
	var cooldown = 0;
	var borderCol = c_white;

	if (!is_undefined(skill)) {

		sprite = skill.icon;

		if (skill.maxCharges > 1) {
			charges = skill.charges;
		}

		cooldown = skill.cooldown / (skill.cooldownTime * 60);

		if (skill.ready()) {
			borderCol = c_aqua;
		}
	}

	var left = xx;
	var top = yy;

	if (!sprite_exists(sprite)) sprite = spr_icon_blank;

	var size = sprite_get_width(sprite);

	switch (align) {
		case 1:
			left = xx - size;
			break;

		case 2:
			left = xx - size;
			top = yy - size;
			break;

		case 3:
			top = yy - size;
			break;
	}

	var right = left + size;
	var bottom = top + size;

	cooldown = clamp(cooldown, 0, 1);

	// background
	draw_set_alpha(1);
	draw_set_colour(c_black);
	draw_rectangle(left, top, right, bottom, false);

	// sprite
	if (!is_undefined(skill)) {
		draw_sprite(sprite, 0, left, top);
	}

	// cooldown overlay
	if (cooldown > 0) {

		var cdHeight = size * cooldown;

		draw_set_alpha(0.55);
		draw_set_colour(c_gray);
		draw_rectangle(left, bottom - cdHeight, right, bottom, false);
		draw_set_alpha(1);
	}

	// border
	draw_set_colour(borderCol);
	draw_rectangle(left, top, right, bottom, true);

	draw_set_font(fnt_normal);

	// key, top left
	if (!is_undefined(skill) and !is_undefined(key)) {
		draw_set_colour(c_aqua);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(left + 3, top + 2, string(key));
	}

	// charges, top right
	if (!is_undefined(charges)) {
		draw_set_colour(c_white);
		draw_set_halign(fa_right);
		draw_set_valign(fa_top);
		draw_text(right - 3, top + 2, string(charges));
	}

	// reset
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(1);
	draw_set_colour(c_white);

}

function scr_ui_damageNumbers(xx, yy, num, col) {

	static range = 64;
	
	var dir = random(360);
	var dist = sqrt(random(1)) * range;
	
	var px = xx + lengthdir_x(dist, dir);
	var py = yy + lengthdir_y(dist, dir);
	
	var inst = instance_create_layer(px, py, "Instances", obj_damageNumbers);
	
	inst.num = num;
	inst.col = col;
	
	return inst;
	
}