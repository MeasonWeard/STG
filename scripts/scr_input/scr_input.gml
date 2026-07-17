/// @func scr_input_check(key, hold)
/// @desc Returns whether the specified input is active.
///
/// @param {Real|Asset|Method|Undefined} key  
///     Keyboard key (vk_*, ord()), mouse button (mb_*),  
///     or callable input (e.g. mouse_wheel_up, mouse_wheel_down).
///
/// @param {Boolean} hold  
///     True = check if held down, False = check if pressed this frame.
///
/// @return {Boolean}
function scr_input_check(key, hold) {
	
	//mouse wheel
	if (is_callable(key)) {

		if (!is_real(key)) {

			return key();
			
		}
	}

	//mouse buttons
	if (key == mb_left or key == mb_middle or key == mb_right) {
		if (hold)
			return mouse_check_button(key);
		else
			return mouse_check_button_pressed(key);
	}

	//keys
	if (is_real(key) and key >= 0) {
		if (hold)
			return keyboard_check(key);
		else
			return keyboard_check_pressed(key);
	}

	//fallback
	return false;
	
}

function scr_input_mouseWheelUp() {
    var val = mouse_wheel_up();
    return (is_real(val) and val > 0);
}

function scr_input_mouseWheelDown() {
    var val = mouse_wheel_down();
    return (is_real(val) and val > 0);
}

function scr_input_keyToString(key) {
	
	//safety
	if (!is_real(key)) return "Unbound";
	
	//letters and numbers
	if ((key >= ord("A") and key <= ord("Z")) or (key >= ord("0") and key <= ord("9"))) return chr(key);
	
	//special keyboard keys
	switch (key) {
		
		case vk_space:      return "Space";
		case vk_enter:      return "Enter";
		case vk_tab:        return "Tab";
		case vk_escape:     return "Esc";
		case vk_backspace:  return "Backspace";

		case vk_shift:      return "Shift";
		case vk_control:    return "Ctrl";
		case vk_alt:        return "Alt";

		case vk_up:         return "Up";
		case vk_down:       return "Down";
		case vk_left:       return "Left";
		case vk_right:      return "Right";

		case vk_add:        return "Num +";
		case vk_subtract:   return "Num -";
		case vk_multiply:   return "Num *";
		case vk_divide:     return "Num /";
		case vk_decimal:    return "Num .";

		// Mouse buttons
		case mb_left:       return "Mouse Left";
		case mb_right:      return "Mouse Right";
		case mb_middle:     return "Mouse Middle";
		case mb_side1:      return "Mouse Side 1";
		case mb_side2:      return "Mouse Side 2";
		
	}

	// Fallback
	return "Key " + string(key);
	
}