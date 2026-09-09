if (!instance_exists(owner)) {
	instance_destroy();
	exit;
}

if (!active) exit;

if (setup) {

	setup = false;
	
	depth = owner.depth - 1;
	yOff = owner.sprite_height + 16;

	lineIndex = 0;

	if (array_length(lines) <= 0) {
		instance_destroy();
		exit;
	}

	timer = scr_dialogue_getDuration(lines[lineIndex]);

}

if (timer > 0) {

	timer--;

} else {

	lineIndex++;

	if (lineIndex >= array_length(lines)) {

		if (loop) {

			lineIndex = 0;

		} else {

			active = false;
			exit;

		}

	}

	timer = scr_dialogue_getDuration(lines[lineIndex]);

}