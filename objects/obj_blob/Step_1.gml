// Inherit the parent event
event_inherited();

if (blobSetup) {

	blobSetup = false;

	scr_audio_playSoundAt(snd_alienShoot2, x, y);
	
	if (level > 1) {
		
		var gun1 = new gun_blobGun (1, 1);
		gun1.damage.kin += level - 1;
		gun1.damage.chem += level - 1;
		scr_weapons_collectWeapon(self, gun1, true);
		
	}
	
	

}