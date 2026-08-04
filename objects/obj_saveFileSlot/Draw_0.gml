//border
var col = mouseHover ? c_lime : c_white;

if (mode == "delete") {

	col = mouseHover ? c_purple : c_red;	
	
}

draw_set_colour(col);
scr_misc_resetTextAlignment();

draw_rectangle(x, y, x + sprite_width, y + sprite_height, true);

var txt = "";

if (!deleting) {

	if (fileLoaded) {
	
		if (is_undefined(name)) name = "_none";
		if (is_undefined(time)) time = "0:0:0";
		if (is_undefined(level)) level = "0";

		txt = name + "\n" + time + "\n" + "Level: " + level;
		txt += mode == "select" ? "\n\nClick to load" : "\n\nWARNING: CLICK TO DELETE";

	} else {

		txt = mode == "select" ? "Click to create a new scientist" : "";
	
	}

} else {

	txt = "DELETE SAVE FILE?";
	txt += "\n\nPRESS DELETE KEY\nTO CONFIRM";
	
}

draw_text(textX, textY, txt);