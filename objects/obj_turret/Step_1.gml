// Inherit the parent event
event_inherited();

if (turretSetup) {

	scr_audio_playSoundAt(snd_turretDeploy, x, y);

	turretSetup = false;

	if (level > 1) {

		var gun1 = new gun_turretGun(1, 1);
		gun1.damage = scr_stats_multiplyDamageProfile(gun1.damage, gunDamMult);
		
		gun1.clipSize += (level - 1);
	
		scr_weapons_collectWeapon(self, gun1, true);
	
	}

}