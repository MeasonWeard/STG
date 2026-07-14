function scr_testSound(){

	audio_play_sound(snd_test, 0, false);

}

function scr_misc_resetTextAlignment() {
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);	
	
}

function append_string(str, word, capitalise) {

	str = (is_undefined(str) or str == "") ? word : str + " " + word;

	if (capitalise and string_length(str) > 0) str = string_upper(string_char_at(str, 1)) 
	+ string_delete(str, 1, 1);
    
    return str;
	
}