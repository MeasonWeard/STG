// Inherit the parent event
event_inherited();

if (fungalSetup) {

	fungalSetup = false;

	if (level > 1) {

		var factor = level * 0.7;
		var gun1 = new gun_fungalGun (1, 1);
		gun1.damage = scr_stats_multiplyDamageProfile(gun1.damage, factor);
		
		gun1.reloadTime -= (level - 1) * 0.036;
	
		scr_weapons_collectWeapon(self, gun1, true);
	
	}

}