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
	
	var totalLoot = alpha + beta + gamma + delta + sigma + omega + unique;
	
	if (totalLoot < 1) {
		
		tab = "continue";
		
	} else {

		draw_set_halign(fa_middle);
		draw_set_font(fnt_large);
		draw_text(titleX, titleY, "Loot");
	
		draw_sprite_ext(spr_lootOrb, 0, lootOrbX, ly1, 1, 1, 0, data.rarities.alpha.col, 1);
		draw_sprite_ext(spr_lootOrb, 1, lootOrbX, ly2, 1, 1, 0, data.rarities.beta.col, 1);
		draw_sprite_ext(spr_lootOrb, 2, lootOrbX, ly3, 1, 1, 0, data.rarities.gamma.col, 1);
		draw_sprite_ext(spr_lootOrb, 3, lootOrbX, ly4, 1, 1, 0, data.rarities.delta.col, 1);
		draw_sprite_ext(spr_lootOrb, 4, lootOrbX, ly5, 1, 1, 0, data.rarities.sigma.col, 1);
		draw_sprite_ext(spr_lootOrb, 5, lootOrbX, ly6, 1, 1, 0, data.rarities.omega.col, 1);
		draw_sprite_ext(spr_lootOrb, 5, lootOrbX, ly7, 1, 1, 0, data.rarities.unique.col, 1);
	
		draw_text(lootOrbTextX, ly1 - 16, alpha);
		draw_text(lootOrbTextX, ly2 - 16, beta);
		draw_text(lootOrbTextX, ly3 - 16, gamma);
		draw_text(lootOrbTextX, ly4 - 16, delta);
		draw_text(lootOrbTextX, ly5 - 16, sigma);
		draw_text(lootOrbTextX, ly6 - 16, omega);
		draw_text(lootOrbTextX, ly7 - 16, unique);
	
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
		
		if (unique > 0) {
	
			uniqueReveal.active = true;
			uniqueScrap.active = true;
		
		}
	
	}
	
}

if (tab == "reveal") {
	
	lockDelay --;
	//generate loot
	var maxLevel = rc.runLevel + 2;
	//maxLevel = 12;
	
	takeButton.active = true;
	scrapAllButton.active = true;
	
	if (revealKey == "unique") {
	
		var len = array_length(uniqueLoot);
		for (var i = 0; i < len; i++) {
		
			var lootFunc = uniqueLoot[i];
			if (!is_callable(lootFunc)) continue;
		
			var lvl = scr_loot_rollLevel(maxLevel);
			var lootItem = lootFunc(lvl);
			
			if (!is_struct(lootItem)) continue;
			
			array_push(revealedLoot, lootItem);
		
		}
		
		uniqueLoot = [];
	
	} else {
	
		var amount = variable_instance_get(self, revealKey);
		var rarityNum = scr_loot_getRarityNum(revealKey);
		
		while (amount > 0) {
		
			var specialChance = min(25, 12 + maxLevel * 0.1 + rarityNum * 0.3);
			var special = scr_random_chance(specialChance);
		
			var newLoot = noone;
			
			if (special) {
				newLoot = scr_loot_generateSpecialLoot(maxLevel, rarityNum);
			} else {
				newLoot = scr_loot_generateGenericLoot(maxLevel, rarityNum);	
			}
			
			array_push(revealedLoot, newLoot);
			amount--;
		
		}
	
	}
	
	//var setTo = lootKey == "unique" ? [] : 0;
	variable_instance_set(self, revealKey, 0);
	
	//draw
	var cap = string_capitalise(revealKey, 1);
	
	draw_set_halign(fa_middle);
	draw_set_font(fnt_large);
	draw_set_colour(c_lime);
	draw_text(titleX, titleY - 60, cap + " Loot");
	
	draw_set_font(fnt_normal);
	draw_set_halign(fa_middle);
	draw_text(titleX, titleY + 60, "Right click individual items to scrap one at a time. Left click to lock items. Locked items won't be scrapped.");
	
	var lootCount = array_length(revealedLoot);
	var itemsPerPage = lootColumns * lootRows;

	var pageCount = ceil(lootCount / itemsPerPage);
	var maxPage = max(pageCount - 1, 0);

	lootPage = clamp(lootPage, 0, maxPage);

	var startIndex = lootPage * itemsPerPage;
	var endIndex = min(startIndex + itemsPerPage, lootCount);

	prevPageButton.active = lootPage > 0;
	nextPageButton.active = lootPage < maxPage;
	
	if(maxPage > 0) {
		draw_set_halign(fa_middle);
		draw_text(pageTextX, titleY + 60, "Page " + string(lootPage + 1) + "/" + string(maxPage + 1));
	}
	
	var lockedLen = array_length(locked);

	for (var i = startIndex; i < endIndex; i++) {

		var pageIndex = i - startIndex;

		var col = pageIndex mod lootColumns;
		var row = pageIndex div lootColumns;

		var slotX = lootLeft + col * (lootSlotSize + lootSlotGap);
		var slotY = lootTop + row * (lootSlotSize + lootSlotGap);

		var args = [i];

		scr_ui_drawItemSlot(
			revealedLoot[i],
			slotX,
			slotY,
			0,
			lootSlotSize,
			fnt_large,
			true,
			lock,
			args,
			scrapRevealed,
			args
		);
		
		var isLocked = false;
		
		for (var j = 0; j < array_length(locked); j++) {
		
			var index = locked[j];
			
			if (i == index) {
				isLocked = true;
				break;
			}
		
		}
		
		if (isLocked) {
		
			draw_sprite(spr_locked, 0, slotX + 8, slotY + 8);
		
		}
		
	}

	
} else {

	lockDelay = 12;
	
}

if (tab == "continue") {


	draw_set_font(fnt_huge);
	
	var dots = 1 + ((current_time div 300) mod 3);

	var dotTxt = "";

	repeat (dots) {
	    dotTxt += ".";
	}
	
	var txt = "Saving game   \n\nReturning to hub.";
	
	draw_set_halign(fa_middle);
	draw_text(titleX, room_height * 0.5 - 120, txt);
	draw_set_halign(fa_left);
	draw_text(titleX + 84, room_height * 0.5 - 120, dotTxt);

}