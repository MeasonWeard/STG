// Inherit the parent event
event_inherited();

if (mechSetup) {

	mechSetup = false;

	scr_audio_playSoundAt(snd_turretDeploy, x, y);
	
	if (level > 1) {
		
		var gun1 = new gun_mechPulseRifle(1, 1);
		gun1.damage = scr_stats_multiplyDamageProfile(gun1.damage, gunDamMult);
		
		scr_weapons_collectWeapon(self, gun1, true);
		
	}
	
	

}