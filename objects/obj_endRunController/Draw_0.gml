xpBar.visible = false;

var lootButtonsLen = array_length(lootButtons);
for (var i = 0; i < lootButtonsLen; i ++) {

	var button = lootButtons[i];
	button.active = false;
	
}

if (tab == "resources") {

	if (resRevealed < resKeysLen) {
		
		if (resTick > 0) {
			resTick --;	
		} else {
			resTick = 15;
			resRevealed ++
			audio_play_sound(snd_coinCollect, 0, false);
		}
	
	}

	draw_set_halign(fa_middle);
	draw_set_font(fnt_large);
	
	draw_text(titleX, titleY, "Resources");
	
	draw_set_font(fnt_normal);
	
	for (var i = 0; i < resRevealed; i++) {

		var key = resKeys[i];
		var res = resources[$ key];
	
		var icon = res.icon;
		var txt = res.txt;
		var val = res.val;
		var xx = res.xx;
		var yy = res.yy;
	
		draw_sprite(icon, 0, xx, yy);
		draw_text(xx, yy + 32, txt);

	}
	

}

if (tab == "xp") {
	
	//caclulate
	if (!xpFinished) {

	    if (newXp > 0) {

	        var speedUp = max(ceil(newXp / 100), 10);

	        // Never add more than the XP remaining.
	        var xpAdded = min(speedUp, newXp);

	        xpDisplay += xpAdded;
	        newXp -= xpAdded;

	        // Process level-ups and preserve overflow.
	        while (xpDisplay >= xpNeeded) {

	            xpDisplay -= xpNeeded;
	            level++;

	            xpNeeded = scr_progression_xpRequired(level);

	            // Level-up sound/effect could be triggered here.
	        }

	    } else {

	        xpFinished = true;

	    }

	}
	
	//draw
	draw_set_halign(fa_middle);
	draw_set_font(fnt_large);

	draw_text(titleX, titleY, "XP");

	//var perc = clamp((xpDisplay / xpNeeded) * 100, 0, 100);
	xpBar.visible = true;
	xpBar.maxValue = xpNeeded;
	xpBar.value = xpDisplay;
	
	draw_text(
	    xMid,
	    titleY + 200,
	    "Data collected: " + string(dataCollected)
	);

	draw_text(
	    xMid,
	    titleY + 300,
	    string(xpDisplay) + " / " + string(xpNeeded)
	);

	draw_text(
	    xMid,
	    titleY + 340,
	    "Level " + string(level)
	);
	
}

if (tab == "loot") {
	
	draw_set_halign(fa_middle);
	draw_set_font(fnt_large);
	
	draw_text(titleX, titleY, "Loot");
	
	draw_sprite_ext(spr_lootOrb, 0, lootOrbX, ly1, 1, 1, 0, data.rarities.alpha.col, 1);
	draw_sprite_ext(spr_lootOrb, 1, lootOrbX, ly2, 1, 1, 0, data.rarities.beta.col, 1);
	draw_sprite_ext(spr_lootOrb, 2, lootOrbX, ly3, 1, 1, 0, data.rarities.gamma.col, 1);
	draw_sprite_ext(spr_lootOrb, 3, lootOrbX, ly4, 1, 1, 0, data.rarities.delta.col, 1);
	draw_sprite_ext(spr_lootOrb, 4, lootOrbX, ly5, 1, 1, 0, data.rarities.sigma.col, 1);
	draw_sprite_ext(spr_lootOrb, 5, lootOrbX, ly6, 1, 1, 0, data.rarities.omega.col, 1);
	
	draw_text(lootOrbTextX, ly1 - 16, alpha);
	draw_text(lootOrbTextX, ly2 - 16, beta);
	draw_text(lootOrbTextX, ly3 - 16, gamma);
	draw_text(lootOrbTextX, ly4 - 16, delta);
	draw_text(lootOrbTextX, ly5 - 16, sigma);
	draw_text(lootOrbTextX, ly6 - 16, omega);
	
	if (alpha > 0) {
	
		alphaReveal.active = true;
		alphaScrap.active = true;
		
	}
	
	if (beta > 0) {
	
		betaReveal.active = true;
		betaScrap.active = true;
		
	}
	
	if (gamma > 0) {
	
		gammaReveal.active = true;
		gammaScrap.active = true;
		
	}
	
	if (delta > 0) {
	
		deltaReveal.active = true;
		deltaScrap.active = true;
		
	}
	
	if (sigma > 0) {
	
		sigmaReveal.active = true;
		sigmaScrap.active = true;
		
	}
	
	if (omega > 0) {
	
		omegaReveal.active = true;
		omegaScrap.active = true;
		
	}
	
}

if (tab == "reveal") {

	//generate loot
	var amount = variable_instance_get(self, revealKey);
	var rarityNum = scr_loot_getRarityNum(revealKey);
	var maxLevel = rc.runLevel;
	
	while (amount > 0) {
		
		var newLoot = scr_loot_generateGenericLoot(maxLevel, rarityNum);
		array_push(revealedLoot, newLoot);
		amount--;
		
	}
	
	variable_instance_set(self, revealKey, 0);
	
	//draw
	var columns = 8;
	var rows = 4;
	var itemsPerPage = columns * rows;

	var startIndex = lootPage * itemsPerPage;
	var endIndex = min(startIndex + itemsPerPage, array_length(revealedLoot));

	for (var i = startIndex; i < endIndex; i++) {

		var pageIndex = i - startIndex;

		var col = pageIndex mod columns;
		var row = pageIndex div columns;

		var slotX = lootLeft + col * (lootSlotSize + lootSlotGap);
		var slotY = lootTop + row * (lootSlotSize + lootSlotGap);

		var args = [i];

		scr_ui_drawItemSlot(
			slotX,
			slotY,
			0,
			lootSlotSize,
			fnt_large,
			revealedLoot[i],
			undefined,
			undefined,
			scrapRevealed,
			args
		);
	}

	
}