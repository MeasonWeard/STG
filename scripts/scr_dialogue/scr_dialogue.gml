function scr_dialogue_setup(char) {

	if (!instance_exists(char)) return false;

	if (variable_instance_exists(char, "dialogueController")) {
		instance_destroy(char.dialogueController);	
	}

	var dc = instance_create_layer(char.x, char.y, "Instances", obj_dialogue);
	dc.owner = char;

	char.dialogueController = dc;
	char.dialogueTriggered = false;
	
	if (!variable_instance_exists(char, "lines")) char.lines = [];
	if (!variable_instance_exists(char, "dialogueTriggered")) char.dialogueTriggered = false;
	if (!variable_instance_exists(char, "loopDialogue")) char.loopDialogue = false;
	if (!variable_instance_exists(char, "repeatDialogue")) char.repeatDialogue = true;
	if (!variable_instance_exists(char, "continueDialogue")) char.continueDialogue = false;
	if (!variable_instance_exists(char, "dialogueTarget")) char.dialogueDialogue = noone;
	if (!variable_instance_exists(char, "dialogueTriggerDist")) char.dialogueTriggerDist = 250;
	
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

function scr_dialogue_stop(char, loop = false) {

	if (!instance_exists(char)) return false;
	if (!instance_exists(char.dialogueController)) return false;

	var dc = char.dialogueController;

	dc.lineIndex = 0;
	dc.active = false;
	dc.timer = 0;

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