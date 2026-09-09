// Inherit the parent event
event_inherited();

if (setupDialogue and array_length(lines) > 0) {

	setupDialogue = false;
	scr_dialogue_setup(self);

}