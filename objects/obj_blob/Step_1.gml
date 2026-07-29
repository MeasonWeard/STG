// Inherit the parent event
event_inherited();

if (blobSetup) {

	blobSetup = false;

	scr_audio_playSoundAt(snd_alienShoot2, x, y);
	
	var gun1 = new gun_blobGun (1, 1);
	
	gun1.damage.kin = kinDam;
	gun1.damage.chem = chemDam;
	
	scr_weapons_collectWeapon(self, gun1, true);
		
}