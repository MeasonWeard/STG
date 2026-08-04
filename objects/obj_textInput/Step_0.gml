// Click to focus
if (mouse_check_button_pressed(mb_left)) {

	var wasFocused = focused;

	focused = point_in_rectangle(
		mouse_x, mouse_y,
		x, y,
		x + width, y + height
	);

	if (focused and !wasFocused) {
		keyboard_string = text;
	}

}

// Read typed text
if (focused) {

	text = keyboard_string;

	if (string_length(text) > maxLength) {
		text = string_copy(text, 1, maxLength);
		keyboard_string = text;
	}

}

if (deleteTimer > 0) deleteTimer --;
if (typeTimer > 0) typeTimer --;