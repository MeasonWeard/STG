// Inherit the parent event
event_inherited();

if (turretSetup) {

	scr_audio_playSoundAt(snd_turretDeploy, x, y);

	turretSetup = false;

	var gun1 = new gun_turretGun(1, 1);
	gun1.damage.kin = kinDam;
		
	gun1.clipSize = ammoPerClip;
	
	scr_weapons_collectWeapon(self, gun1, true);
	

}