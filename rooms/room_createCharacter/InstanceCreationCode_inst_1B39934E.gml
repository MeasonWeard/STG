txt = "Confrim";
cc = global.createCharacterController;

leftFunc = function() {

	var name = cc.name;
	var valid = false;
	
	if (is_string(name)) {
		var len = string_length(name);
		if (len > 0) valid = true;
	}
	
	if (!valid) {
		cc.textInput.borderCol = c_red;
		audio_play_sound(snd_error, 1, false);
		exit;	
	}
	
	global.gameData.playerData.name = name;
	room_goto(room_classSelect);
	
}