if (mode == "aim") {
	
	//reticle
	var rad = 8;
	var playerExists = instance_exists(player);
	
	if (playerExists and is_struct(player.gun)) {
		rad = player.gun.aimOff * 4;
	}
	
	draw_set_colour(c_red);
	
	draw_circle(x, y, 2, false);
	
	draw_circle(x, y, rad, true);
	
	//melee
	if (playerExists and showMelee and is_struct(player.melee)) {
	
		var melee = player.melee;
	
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
				
				var perc = 1 - (melee.recharge / (melee.rechargeTime * 60));
				perc *= 100;
				
				if (perc >= 15) draw_healthbar(meleeBarLeft, meleeBarTop, meleeBarRight, meleeBarBottom, perc, c_grey, meleeBarCol, meleeBarCol, 0, true, true);
				
			}
		
		
		}

	}
	
	//reload
	if (showReload and playerExists) {
		
		var gun = player.gun;
		
		if (is_struct(gun)) {
		
			if (gun.reload > 0) {
				
				var perc = 1 - (gun.reload / (gun.reloadTime * 60));
				perc *= 100;
				
				draw_healthbar(reloadBarLeft, reloadBarTop, reloadBarRight, reloadBarBottom, perc, c_grey, reloadBarCol, reloadBarCol, 0, true, true);
				
			}
		
		
		}
		
	}
	
	//show ammo
	if (playerExists and showAmmo) {
	
		var gun = player.gun;
		
		if (playerExists and is_struct(gun)) {
			
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
		
		if (playerExists and is_struct(player.gun)) {
			
			//var prevCol = draw_get_colour();
			draw_set_halign(fa_middle);
			draw_set_colour(c_white);
		
			draw_text(gunNameX, gunNameY, player.gun.name);
		
		}
	
	}
	
	
	//debug
	if (global.debug) draw_text(x + 50, y - 50, rad);
	
	
} else {

	draw_self();
	
}