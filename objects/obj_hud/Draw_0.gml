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

xpBarX = camXmid;
xpBarY = healthBarY + 20;

lvlTxtX = camXmid;
lvlTxtY = healthBarY - 16;

dashX = camXmid - 400;
dashY = camY + camH - 20;

skillsX = camXmid + 400;//camX + camW - camW * 0.33;
skillsY = dashY;

stimPackX = dashX + skillIconW + skillsPad;
energyPackX = stimPackX + skillIconW + skillsPad;

shieldX = healthBarX - healthBar.width * 0.5 + 16;
shieldY = healthBarY - 32;

posX = instance_exists(rc) ? rc.posX : 0;
posY = instance_exists(rc) ? rc.posY : 0;

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
	dashRecharge = player.dashRecharge;
	xp = player.xp;
	xpReq = player.xpRequired;
	lvl = player.level;

	shieldRecharge = player.shieldRegenCounter > 0 ? true : false;
	
	stimPacks = player.stimPacks;
	energyPacks = player.energyPacks;
	
	stimPackCool = player.stimPackRecharge / 3600;
	energyPackCool = player.energyPackRecharge / 3600;
	
	skill1 = player.skills.skill1;
	skill2 = player.skills.skill2;
	skill3 = player.skills.skill3;
	skill4 = player.skills.skill4;
	
	skills = [skill1, skill2, skill3, skill4];

} else {

	hp = 0;
	energy = 0;
	shield = 0;
	
}

//damage flash
if (!firstStep) {
	
	if (shield < prevShield) {
	
		flashAlpha = 1;
		flashCol = c_purple;
	
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
if (!sc.hub) scr_ui_drawMiniMap(miniMap, 12, mapX, mapY, posX, posY);

//HEALTH BAR, ENERGY BAR, XP BAR AND SHIELDS

//health bar
healthBar.value = hp;
healthBar.maxValue = maxHp;
healthBar.x = healthBarX;
healthBar.y = healthBarY;
healthBar.txt = string(hp) + " / " + string(maxHp);

//energy bar
energyBar.value = energy;
energyBar.maxValue = maxEnergy;
energyBar.x = energyBarX;
energyBar.y = energyBarY;
energyBar.txt = string(energy) + " / " + string(maxEnergy);

//xp bar
xpBar.x = xpBarX;
xpBar.y = xpBarY;
xpBar.maxValue = xpReq;
xpBar.value = xp;

if (maxShield > 0) {

	var subImage = shield > 0 ? 0 : 1;
	
	draw_set_font(fnt_normal);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_sprite(spr_shieldIcon, subImage, shieldX, shieldY);
	draw_text(shieldX + 24, shieldY - 8, string(shield) + "/" + string(maxShield));
	
	if(shieldRecharge) {
	
		var drawRecharge = (current_time mod 800) < 400;
		if (drawRecharge) draw_sprite(spr_shieldRechargeIcon, 0, shieldX, shieldY);
	
	}

}

//player level
draw_circle_colour(lvlTxtX, lvlTxtY, 24, #77e3da, #77e3da, false);
draw_set_colour(c_black);
draw_circle(lvlTxtX, lvlTxtY, 24, true);
draw_set_font(fnt_large);
draw_set_halign(fa_middle);
draw_set_valign(fa_middle);
draw_text(lvlTxtX, lvlTxtY, string(lvl));

//enemy health bar and shields
var enemy = cursor.enemy;
if (instance_exists(enemy)) {

	var xx = camXmid;
	var yy = camY + 40;

	enemyHpBar.x = xx;
	enemyHpBar.y = yy;
	
	var enemyHp = enemy.hp;
	var enemyMaxHp = enemy.maxHp;
	var enemyName = enemy.name;
	var enemyLevel = enemy.level;
	var enemyMaxShield = enemy.maxShield;
	var enemyShield = enemy.shield;
	var enemyMaxEnergy = enemy.maxEnergy;
	var enemyEnergy = enemy.energy;

	enemyHpBar.visible = true;
	enemyHpBar.value = enemyHp;
	enemyHpBar.maxValue = enemyMaxHp;
	enemyHpBar.txt = string(enemyHp) + " / " + string(enemyMaxHp);
	draw_set_halign(fa_middle);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_normal);
	draw_set_colour(c_white);
	draw_text(xx, yy - 22, enemyName + "   lvl " + string(enemyLevel));
	
	if (enemyMaxShield > 0) {

		var subImage = enemyShield > 0 ? 0 : 1;
	
		var esX = xx - enemyHpBar.width * 0.5 + 16;
		var esY = yy + 26;
	
		draw_set_font(fnt_normal);
		draw_set_halign(fa_left);
		draw_sprite(spr_shieldIcon, subImage, esX, esY);
		draw_text(esX + 16, esY, string(enemyShield) + "/" + string(enemyMaxShield));
	
	}
	
	if (enemyMaxEnergy > 0) {
		
		enemyEnergyBar.visible = true;
		enemyEnergyBar.value = enemyEnergy;
		enemyEnergyBar.maxValue = enemyMaxEnergy;
		
		if (enemyMaxShield > 0) {
			
			enemyEnergyBar.width = enemyHpBar.width - 80;
			enemyEnergyBar.x = xx + 40;
			enemyEnergyBar.y = yy + 20;
			
		} else {
			
			enemyEnergyBar.width = enemyHpBar.width;
			enemyEnergyBar.x = xx;
			enemyEnergyBar.y = yy + 20;
		
		}
		
	} else {
		
		enemyEnergyBar.visible = false;
		
	}
	
} else {

	enemyHpBar.visible = false;
	enemyEnergyBar.visible = false;
}



//dash
scr_ui_skillIconFromData(dashX, dashY, 3, spr_icon_dash, "Dash", "", dashes, dashRecharge, false);

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