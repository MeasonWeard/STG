//formatting
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camXmid = camX + camW * 0.5;
camYmid = camY + camH * 0.5;

instructionsX = camX + camW - 64;
instructionsY = camY + 64;

mapX = camX + 32;
mapY = camY + 32;

healthBarX = camX + 220;
healthBarY = camY + camH - 28;

energyBarX = camX + camW - 220;
energyBarY = camY + camH - 28;

dashX = camX + camW * 0.33;
dashY = camY + camH - 20;

skillsX = camX + camW - camW * 0.33;
skillsY = dashY;

stimPackX = dashX + skillIconW + skillsPad;
energyPackX = stimPackX + skillIconW + skillsPad;

//get info
if (instance_exists(player)) {
	
	hp = player.hp;
	maxHp = player.maxHp;
	shield = player.shield;
	maxShield = player.maxShield;
	energy = player.energy;
	maxEnergy = player.maxEnergy;
	dashes = player.dashes;
	maxDashes = player.finalStats.maxDashes;
	dashCool = player.dashCool;
	dashCoolTime = player.finalStats.dashCoolTime;
	dashCoolPerc = dashCool / (dashCoolTime * 60);
	
	stimPacks = player.stimPacks;
	energyPacks = player.energyPacks;
	
	stimPackCool = player.stimPackRecharge / 3600;
	energyPackCool = player.energyPackRecharge / 3600;
	
	skill1 = player.skills.skill1;
	skill2 = player.skills.skill2;
	skill3 = player.skills.skill3;
	skill4 = player.skills.skill4;
	
	skills = [skill1, skill2, skill3, skill4];

}

//damage flash
if (!firstStep) {
	
	if (shield < prevShield) {
	
		flashAlpha = 1;
		flashCol = c_white;
	
	}

	if (hp < prevHp) {
	
		flashAlpha = 1;
		flashCol = #FF0009;
	
		if (hp <= ceil(maxHp * 0.33)) {
			fullFlashAlpha = 1;
			fullFlashCol = #FF0009;
			flashAlpha = 3;
		}
	
	} //else if (hp > prevHp and !firstStep) {
	
		//flashAlpha = 1;
		//flashCol = c_lime;
	
	//}

	if (flashAlpha > 0) {

		draw_sprite_ext(spr_edgeFlash, 0, camX, camY, 1, 1, 0, flashCol, flashAlpha);
	
		flashAlpha -= 0.075;
	
	}

	if (fullFlashAlpha > 0) {

		draw_sprite_ext(spr_fullScreenFlash, 0, camX, camY, 1, 1, 0, flashCol, fullFlashAlpha);
		fullFlashAlpha -= 0.075;
	
	}

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

//health and energy
healthBar.value = hp;
healthBar.maxValue = maxHp;
healthBar.x = healthBarX;
healthBar.y = healthBarY;

energyBar.value = energy;
energyBar.maxValue = maxEnergy;
energyBar.x = energyBarX;
energyBar.y = energyBarY;

//dash
scr_ui_skillIconFromData(dashX, dashY, 3, spr_icon_dash, "Dash", "", dashes, dashCoolPerc, false);

//packs
scr_ui_skillIconFromData(stimPackX, skillsY, 3, spr_icon_stimPack, "StimPac", "Q", stimPacks, stimPackCool, true);
scr_ui_skillIconFromData(energyPackX, skillsY, 3, spr_icon_energyPack, "Energy Pack", "E", energyPacks, energyPackCool, true);

//skills
var skillsLen = array_length(skills);
var pos = 0;

for (var i = skillsLen - 1; i >= 0; i--) {

	var thisSkill = skills[i];
	var key = i + 1;

	var xx = skillsX - pos * (skillsPad + skillIconW);

	scr_ui_skillIcon(xx, skillsY, 2, key, thisSkill);

	pos++;
	
}

prevHp = hp;
prevShield = shield;
firstStep = false;