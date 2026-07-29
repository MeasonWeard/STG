// Inherit the parent event
event_inherited();

if (symbiontSetup) {

	symbiontSetup = false;

	scr_audio_playSoundAt(snd_alienShoot2, x, y);
	
	var melee1 = new melee_symbiontSlash(1, 1);
	melee1.damage.kin = kinDam;
	scr_weapons_collectWeapon(self, melee1, true);
	
	show_debug_message(melee1);
		
}