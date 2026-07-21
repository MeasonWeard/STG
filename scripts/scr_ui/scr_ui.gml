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

	if (!is_array(miniMap)) exit;

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

function scr_ui_skillIconFromData(xx, yy, align, sprite, name, key, charges, cooldown, blackout, showText = true) {

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

	//blackout
	if (blackout and charges <= 0) {
		
		draw_set_alpha(0.8);
		draw_set_colour(c_black);
		draw_rectangle(left, top, right, bottom, false);
		draw_set_alpha(1);
		
	}

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
	
	draw_set_font(fnt_normal);
	
	//key, top left
	draw_set_colour(c_aqua);
	if (showText and !is_undefined(key)) {
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_text(left + 3, top + 2, string(key));
	}

	//charges, top right
	if (showText and !is_undefined(charges)) {
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

function scr_ui_risingNumbers(xx, yy, num, col) {

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

function scr_ui_damageNumbers(amount, char, hitOutcome = 1) {

	if (amount != 0) {
		
		var col = amount < 0 ? c_lime : c_red;
		col = hitOutcome > 1 ? c_yellow : col;
		
		var num = abs(amount);
	
		var px = char.x;
		var py = char.y - char.sprite_height * 0.75;
	
		var inst = scr_ui_risingNumbers(px, py, num, col);
		
		if (hitOutcome > 1) inst.size = 2;
		if (hitOutcome < 1) inst.size = 0;
		
	}
	
}

function scr_ui_drawItemSlot(item, xx, yy, align, size, font, drawBackground, leftFunc = undefined, leftArgs = [], rightFunc = undefined, rightArgs = []) {

	var left = xx;
	var top = yy;
	
	var mx = mouse_x;
	var my = mouse_y;
	
	var borderCol = c_white;
	
	var prevCol = draw_get_colour();

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
	
	
	if (is_struct(item)) {
		
		var rarity = item.rar;
		var rarityInfo = scr_loot_getRarityInfo(rarity);
		borderCol = rarityInfo.col;
		
		var spr = item.spr;
		var midX = left + size * 0.5;
		var midY = top + size * 0.5;
		
		if (drawBackground) {
		
			var h = color_get_hue(borderCol);
			var s = color_get_saturation(borderCol);
			var v = color_get_value(borderCol);

			v *= 0.1;
			v = clamp(v, 0, 255);

			var bgCol =  make_color_hsv(h, s, v);
		
			draw_set_colour(bgCol);
			draw_rectangle(left, top, right, bottom, false);
	
		}
		
		draw_sprite(spr, 0, midX, midY);
		
		var mouseInArea = mx > left and mx < right and my > top and my < bottom;
		
		if (mouseInArea) {
			
			var func = scr_gear_formatDescription;
			if (is_instanceof(item, gunInst)) func = scr_guns_formatDescription;
			if (is_instanceof(item, meleeInst)) func = scr_melee_formatDescription;
			
			if (!is_string(item.description)) item.description = func(item);
			
			scr_ui_mouseHoverText(item.description, font);
			
			if (is_callable(leftFunc) and mouse_check_button_pressed(mb_left)) method_call(leftFunc, leftArgs);
			if (is_callable(rightFunc) and mouse_check_button_pressed(mb_right)) method_call(rightFunc, rightArgs);
			
		}
		
	}
	
	draw_set_colour(borderCol);
	draw_rectangle(left, top, right, bottom, true);
	
	draw_set_colour(prevCol);
	
}

function scr_ui_drawTextBox(xx, yy, txt, font) {

	var prevFont = draw_get_font();
	draw_set_font(font);

	var pad = 6;

	var w = string_width(txt) + pad * 2;
	var h = string_height(txt) + pad * 2;

	var screenW = display_get_gui_width();
	var screenH = display_get_gui_height();

	var drawX = xx;
	var drawY = yy;

	// Flip horizontally if it would leave the screen
	if (drawX + w > screenW) {
		drawX = xx - w;
	}

	// Flip vertically if it would leave the screen
	if (drawY + h > screenH) {
		drawY = yy - h;
	}

	// Final clamp in case the box is larger than the available space
	drawX = clamp(drawX, 0, max(0, screenW - w));
	drawY = clamp(drawY, 0, max(0, screenH - h));

	scr_misc_resetTextAlignment();

	draw_set_color(global.data.colours.windowBackground);
	draw_rectangle(drawX, drawY, drawX + w, drawY + h, false);

	draw_set_color(global.data.colours.windowText);
	draw_rectangle(drawX, drawY, drawX + w, drawY + h, true);

	draw_text(drawX + pad, drawY + pad, txt);

	draw_set_font(prevFont);

}

function scr_ui_mouseHoverText(txt, font) {
	
	global.cursor.hoverFont = font;
	global.cursor.hoverTxt = txt;
	global.cursor.hoverTxtCount = 4;
	
}

function scr_ui_displayTag(xx, yy, lineDist, txt, col = c_lime, font = fnt_normal, lineDir = 35) {

	var prevCol    = draw_get_colour();
	var prevFont   = draw_get_font();
	var prevHAlign = draw_get_halign();
	var prevVAlign = draw_get_valign();

	var dirX = lengthdir_x(1, lineDir);
	var dirY = lengthdir_y(1, lineDir);

	var endX = xx + dirX * lineDist;
	var endY = yy + dirY * lineDist;

	var textGap = 4;
	var textX = endX + dirX * textGap;
	var textY = endY + dirY * textGap;

	// Horizontal alignment
	if (dirX > 0.01) {
		draw_set_halign(fa_left);
	} else if (dirX < -0.01) {
		draw_set_halign(fa_right);
	} else {
		draw_set_halign(fa_center);
	}

	// Vertical alignment
	if (dirY > 0.01) {
		draw_set_valign(fa_top);
	} else if (dirY < -0.01) {
		draw_set_valign(fa_bottom);
	} else {
		draw_set_valign(fa_middle);
	}

	draw_set_colour(col);
	draw_set_font(font);

	draw_line(xx, yy, endX, endY);
	draw_text(textX, textY, txt);

	draw_set_colour(prevCol);
	draw_set_font(prevFont);
	draw_set_halign(prevHAlign);
	draw_set_valign(prevVAlign);
	
	scr_misc_resetTextAlignment();
	
}