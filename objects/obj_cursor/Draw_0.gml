if (mode == "aim") {
	
	var rad = 8;
	var playerExists = instance_exists(player);
	
	//gun
	if (playerExists and is_instanceof(player.equippedWeapon, gunInst)) {
		
		rad = player.equippedWeapon.aimOff * 4;
		
	}
	
	//melee
	if (playerExists and showMelee and is_instanceof(player.equippedWeapon, meleeInst)) {
	
		rad = 8;
		
		var melee = player.equippedWeapon;
		var stats = player.equippedWeaponStats;
	
		if (playerExists and is_struct(melee)) {
		
			if (melee.charges > 0) {
				
				var prevCol = draw_get_colour();
				draw_set_colour(meleeBarCol);
				draw_set_valign(fa_middle);
				draw_text(meleeNumX, meleeNumY, string(melee.charges));
				draw_set_colour(prevCol);
				scr_misc_resetTextAlignment();
				
			} 
				
			if (melee.recharge > 0) {
				
				var perc = 1 - (melee.recharge / (stats.rechargeTime * 60));
				perc *= 100;
				
				if (perc >= 15) draw_healthbar(meleeBarLeft, meleeBarTop, meleeBarRight, meleeBarBottom, perc, c_grey, meleeBarCol, meleeBarCol, 0, true, true);
				
			}
		
		
		}

	}

	//reticle
	draw_set_colour(c_red);
	draw_circle(x, y, 2, false);
	draw_circle(x, y, rad, true);
	
	//reload
	if (showReload and playerExists) {
		
		var gun = player.equippedWeapon;
		
		if (is_instanceof(gun, gunInst)) {
		
			if (gun.reload > 0) {
				
				var perc = 1 - (gun.reload / (gun.reloadTime * 60));
				perc *= 100;
				
				draw_healthbar(reloadBarLeft, reloadBarTop, reloadBarRight, reloadBarBottom, perc, c_grey, reloadBarCol, reloadBarCol, 0, true, true);
				
			}
		
		
		}
		
	}
	
	//show ammo
	if (playerExists and showAmmo) {
	
		draw_set_font(fnt_normal);
	
		var gun = player.equippedWeapon;
		
		if (playerExists and is_instanceof(gun, gunInst)) {
			
			var prevCol = draw_get_colour();
			draw_set_colour(reloadBarCol);
			draw_set_halign(fa_right);
			draw_set_valign(fa_middle);
			
			var ammoString = string(gun.ammo) + "/" + string(gun.clipSize);
			
			draw_text(ammoNumX, ammoNumY, ammoString);
			
			draw_set_colour(prevCol);
			scr_misc_resetTextAlignment();
		}
	
	}
	
	//gun name
	if (gunNameTick > 0) {
	
		gunNameTick --;
		
		if (playerExists and is_instanceof(player.equippedWeapon, weaponInst)) {
			
			//var prevCol = draw_get_colour();
			draw_set_halign(fa_middle);
			draw_set_colour(c_white);
		
			draw_text(gunNameX, gunNameY, player.equippedWeapon.name);
		
		}
	
	}
	
	
	//debug
	if (global.debug) draw_text(x + 50, y - 50, rad);
	
	
} else {

	draw_self();
	
}