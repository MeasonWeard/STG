// Inherit the parent event
event_inherited();

if (symbiontSetup) {

	symbiontSetup = false;

	scr_audio_playSoundAt(snd_alienShoot2, x, y);
	
	if (level > 1) {
		
		var melee1 = new melee_symbiontSlash(1, 1);
		melee1.damage.kin += (level - 1) * damExtra;
		scr_weapons_collectWeapon(self, melee1, true);
		
	}
	
}