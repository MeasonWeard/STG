function scr_testSound(){

	audio_play_sound(snd_test, 0, false);

}

function scr_misc_resetTextAlignment() {
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);	
	
}