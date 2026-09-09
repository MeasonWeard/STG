event_inherited();

if (!instance_exists(dialogueTarget)) exit;

var dc = dialogueController;
var dist = point_distance(x, y, dialogueTarget.x, dialogueTarget.y);


// Start dialogue
if (!dialogueTriggered) {

	if (dist <= dialogueTriggerDist) {

		dialogueTriggered = true;
		scr_dialogue_start(self, loopDialogue);

	}

} else {

	// Leave range while dialogue is active
	if (
		dc.active
		and dist > dialogueTriggerDist
		and !continueDialogue
	) {

		scr_dialogue_stop(self);

		if (repeatDialogue) {
			dialogueTriggered = false;
		}

	}

	// Dialogue has ended, and player has since moved away
	else if (
		!dc.active
		and dist > dialogueTriggerDist
		and repeatDialogue
	) {

		dialogueTriggered = false;

	}

}