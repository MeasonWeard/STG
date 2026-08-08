playerExists = instance_exists(player) and player.active;

if (playerExists and is_instanceof(player.equippedWeapon, weaponInst)) {
	mode = "aim";	
} else {
	mode = "point";	
}

//hover text
if (hoverTxt != undefined and hoverTxtCount > 0) {
	
	scr_ui_drawTextBox(x, y, hoverTxt, hoverFont);
	
	hoverTxtCount--;
	
}

//cursor
if (mode == "aim") {
	
	var rad = 8;

	// reticle
	//draw_set_colour(c_red);
	//draw_circle(x, y, 2, false);
	//draw_circle(x, y, rad, true);

	// common weapon display values
	var weapon = player.equippedWeapon;

	var ammo = 0;
	var maxAmmo = 0;

	var reload = 0;
	var reloadTime = 0;

	var ammoCol = c_white;

	if (is_instanceof(weapon, weaponInst)) {

		if (weapon.type == itemTypes.gun) {

			ammo = weapon.ammo;
			maxAmmo = weapon.clipSize;

			reload = weapon.reload;
			reloadTime = weapon.reloadTime;

			ammoCol = c_white;

			// gun aim reticle
			rad = weapon.aimOff * 4;

		}

		if (weapon.type == itemTypes.melee) {

			ammo = weapon.charges;
			maxAmmo = weapon.maxCharges;

			reload = weapon.recharge;
			reloadTime = weapon.rechargeTime;

			ammoCol = c_yellow;

			rad = 8;

		}

	}

	// redraw reticle with correct radius
	draw_set_colour(c_red);
	draw_circle(x, y, 2, false);
	draw_circle(x, y, rad, true);

	// ammo / charges
	if (showAmmo and is_instanceof(weapon, weaponInst)) {

		var prevCol = draw_get_colour();

		draw_set_font(fnt_normal);
		draw_set_colour(ammoCol);
		draw_set_halign(fa_right);
		draw_set_valign(fa_middle);

		var ammoString = string(ammo) + "/" + string(maxAmmo);

		draw_text(ammoNumX, ammoNumY, ammoString);

		draw_set_colour(prevCol);
		scr_misc_resetTextAlignment();

	}


	// reload / recharge bar
	if (showReload and is_instanceof(weapon, weaponInst)) {

		if (reload > 0 and reloadTime > 0) {

			var perc = 1 - (reload / (reloadTime * 60));
			perc *= 100;

			draw_healthbar(
				reloadBarLeft,
				reloadBarTop,
				reloadBarRight,
				reloadBarBottom,
				perc,
				c_grey,
				ammoCol,
				ammoCol,
				0,
				true,
				true
			);

		}

	}


	// weapon name
	if (alwaysShowName) gunNameTick = 12;
	
	if (gunNameTick > 0) {

		gunNameTick--;
		

		if (playerExists and is_instanceof(weapon, weaponInst)) {

			draw_set_halign(fa_middle);
			draw_set_colour(ammoCol);

			draw_text(gunNameX, gunNameY, weapon.name);

			scr_misc_resetTextAlignment();

		}

	}
	
} else {

	draw_self();
	
}

