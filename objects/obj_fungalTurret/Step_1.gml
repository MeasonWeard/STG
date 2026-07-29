// Inherit the parent event
event_inherited();

if (fungalSetup) {

	scr_audio_playSoundAt(snd_alienShoot2, x, y);

	fungalSetup = false;

	var gun1 = new gun_fungalGun (1, 1);
	gun1.damage.kin = kinDam;
	gun1.damage.chem = chemDam;
		
	gun1.reloadTime -= (level - 1) * 0.036;
	
	scr_weapons_collectWeapon(self, gun1, true);
	
	

}