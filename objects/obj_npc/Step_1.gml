// Inherit the parent event
event_inherited();

if (setupDialogue) {

	setupDialogue = false;
	scr_dialogue_createController(self);

}