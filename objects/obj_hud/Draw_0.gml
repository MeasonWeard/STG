camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);

instructionsX = camX + camW - 64;
instructionsY = camY + 64;

var mapX = camX + 32;
var mapY = camY + 32;

//instructions
if (is_string(instructions) and instructionsTick > 0) {

	instructionsTick --;

	var col = c_lime;

	if (instructionsFlash > 0) {
		
	    if ((instructionsFlash mod 40) >= 20) {
	        col = c_white;
	    }
		
		instructionsFlash --;
		
	}

	var prevFont = draw_get_font();
	var prevCol = draw_get_colour();
	draw_set_font(fnt_large);
	draw_set_colour(col);
	draw_set_halign(fa_right);
	draw_set_valign(fa_top);
	
	draw_text(instructionsX, instructionsY, instructions);
	
	if (instructionsTick == 0) instructions = "";
	
	draw_set_font(prevFont);
	draw_set_colour(prevCol);
	scr_misc_resetTextAlignment();
	
}

//minimap
scr_ui_drawMiniMap(miniMap, 12, mapX, mapY, rc.posX, rc.posY);