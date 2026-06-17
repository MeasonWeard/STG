//formatting
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camXmid = camX + camW * 0.5;
camYmid = camY + camH * 0.5;

instructionsX = camX + camW - 64;
instructionsY = camY + 64;

mapX = camX + 32;
mapY = camY + 32;

healthBarX = camXmid;
healthBarY = camY + camH - 20;

//get info
if (instance_exists(player)) {
	
	hp = player.hp;
	maxHp = player.maxHp;
	shield = player.shield;
	maxShield = player.maxShield;
	dashes = player.dashes;
	maxDashes = player.finalStats.maxDashes;
	dashCool = player.dashCool;

}

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

//health bar
healthBar.value = hp;
healthBar.maxValue = maxHp;
healthBar.x = healthBarX;
healthBar.y = healthBarY;

//var hpPerc = (hp / maxHp) * 100;
//draw_healthbar(healthBarLeft, healthBarTop, healthBarRight, healthBarBottom, hpPerc, c_black, c_red, c_red, 0, true, true);