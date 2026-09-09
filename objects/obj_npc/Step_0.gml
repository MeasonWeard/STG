// Inherit the parent event
event_inherited();

if (!dialogueTriggered) {

	if (instance_exists(player)) {

		var dist = point_distance(x, y, player.x, player.y);

		if (dist < 250) {

			dialogueTriggered = true;
			scr_dialogue_start(self);

		}
	
	}

}