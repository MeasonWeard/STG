function scr_testSound(){

	audio_play_sound(snd_test, 0, false);

}

function scr_misc_resetTextAlignment() {
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);	
	
}

/// @function append_string(str, word, capitalise)
/// @param {string} str          The existing string.
/// @param {string} word         The word to append.
/// @param {real} capitalise     Capitalisation mode:
///                              -1 = all lowercase
///                               0 = no change
///                               1 = capitalise first letter of the entire string
///                               2 = capitalise first letter of every word
///                               3 = all uppercase
/// @returns {string} The combined string.
function append_string(str, word, capitalise) {

	// Treat undefined values as empty strings
	if (is_undefined(str)) str = "";
	if (is_undefined(word)) word = "";

	// Only append the word if it contains something
	if (word != "") {
		str = (str == "") ? word : str + " " + word;
	}

	switch (capitalise) {

		case -1:
			str = string_lower(str);
			break;

		case 0:
			// No capitalisation changes
			break;

		case 1:
			if (string_length(str) > 0) {
				str = string_upper(string_char_at(str, 1))
					+ string_delete(str, 1, 1);
			}
			break;

		case 2:
			if (string_length(str) > 0) {

				var words = string_split(str, " ");

				for (var i = 0; i < array_length(words); i++) {

					if (string_length(words[i]) > 0) {
						words[i] = string_upper(string_char_at(words[i], 1))
							+ string_delete(words[i], 1, 1);
					}
				}

				str = string_join_ext(" ", words);
			}
			break;

		case 3:
			str = string_upper(str);
			break;
	}

	return str;
}

/// @function string_capitalise(str, capitalise)
/// @param {string} str          The string to format.
/// @param {real} capitalise     Capitalisation mode:
///                              -1 = all lowercase
///                               0 = no change
///                               1 = capitalise first letter of the entire string
///                               2 = capitalise first letter of every word
///                               3 = all uppercase
/// @returns {string} The formatted string.
function string_capitalise(str, capitalise) {

	if (is_undefined(str)) str = "";

	switch (capitalise) {

		case -1:
			str = string_lower(str);
			break;

		case 0:
			// No capitalisation changes
			break;

		case 1:
			if (string_length(str) > 0) {
				str = string_upper(string_char_at(str, 1))
					+ string_delete(str, 1, 1);
			}
			break;

		case 2:
			if (string_length(str) > 0) {

				var words = string_split(str, " ");

				for (var i = 0; i < array_length(words); i++) {

					if (string_length(words[i]) > 0) {
						words[i] = string_upper(string_char_at(words[i], 1))
							+ string_delete(words[i], 1, 1);
					}
				}

				str = string_join_ext(" ", words);
			}
			break;

		case 3:
			str = string_upper(str);
			break;
	}

	return str;
}

function string_trimDecimals(value, places) {

	var mult = power(10, places);
	var str = string_format(round(value * mult) / mult, 0, places);

	while (string_char_at(str, string_length(str)) == "0") {
		str = string_delete(str, string_length(str), 1);
	}

	if (string_char_at(str, string_length(str)) == ".") {
		str = string_delete(str, string_length(str), 1);
	}

	return str;

}

function scr_showDevInfo() {

	var txt = ""

	if(global.devControls) txt += "Dev controls on\n";
	if(global.debug) txt += "Debugging on";

	if (txt != "") {

		depth = layers.ui;
		var cam = view_camera[0];
		var camX = camera_get_view_x(cam);
		var camY = camera_get_view_y(cam);

		draw_set_colour(c_blue);
		draw_set_font(fnt_normal);
		draw_text(camX + 12, camY + 12, txt);

	}
	
}

function scr_isPointOffScreen(xx, yy, margin = 0) {

	var cam = view_camera[0];

	var camX = camera_get_view_x(cam);
	var camY = camera_get_view_y(cam);
	var camW = camera_get_view_width(cam);
	var camH = camera_get_view_height(cam);

	return (
		xx < camX - margin
		or xx > camX + camW + margin
		or yy < camY - margin
		or yy > camY + camH + margin
	);

}