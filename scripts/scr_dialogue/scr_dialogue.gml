function scr_dialogue_createController(char) {

	if (!instance_exists(char)) return false;

	var dc = instance_create_layer(char.x, char.y, "Instances", obj_dialogue);

	char.dialogueController = dc;
	dc.owner = char;
	
	return dc;
	
}

function scr_dialogue_start(char, loop = false) {

	if (!instance_exists(char)) return false;
	if (!instance_exists(char.dialogueController)) return false;

	var dc = char.dialogueController;
	var lines = char.lines;

	if (array_length(lines) <= 0) return false;

	dc.lines = lines;
	dc.lineIndex = 0;
	dc.loop = loop;
	dc.active = true;

	dc.timer = scr_dialogue_getDuration(lines[0]);

	return true;

}

function scr_dialogue_getDuration(text) {

	if (!is_string(text)) return 0;

	var clean = string_trim(text);

	if (clean == "") return 0;

	var words = string_count(" ", clean) + 1;

	var minTime = 90;
	var timePerWord = 18;

	return max(minTime, words * timePerWord);

}