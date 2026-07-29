// Inherit the parent event
event_inherited();

if (mechSetup) {

	mechSetup = false;

	scr_audio_playSoundAt(snd_turretDeploy, x, y);
	
	var gun1 = new gun_mechPulseRifle(1, 1);
	gun1.damage.kin = kinDam;
		
	scr_weapons_collectWeapon(self, gun1, true);
		
	
}