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
	dc.setup = true;

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

function scr_dialogue_getBoxLayout(owner, txt, xOffset = 0, yOffset = 0) {
	
	static pad = 8;
	static gap = 16;
	
	if (!instance_exists(owner)) return undefined;
	
	draw_set_halign(fa_middle);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_normal);
	
	var w = string_width(txt) + pad * 2;
	var h = string_height(txt) + pad * 2;
	
	var xx = owner.x + xOffset;
	
	var bottom = owner.y - owner.sprite_height - gap + yOffset;
	var yy = bottom - h * 0.5;
	
	return {
		xx: xx,
		yy: yy,
		left: xx - w * 0.5,
		right: xx + w * 0.5,
		top: yy - h * 0.5,
		bottom: bottom
	};
	
}