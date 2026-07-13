xpBar.visible = false;

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
	
}