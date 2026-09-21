if (delay > 0) {

	delay --;
	exit;
	
}

scr_obj_mouseHover();

if (mouseHover and (mouse_check_button(mb_left) or mouse_check_button(mb_right))) {
	
	if (object_exists(obj)) {
	
		with (obj) {
		
			variable_instance_set(self, other.key, other.col);
			reset = true;
		
		}
	
	}
	
}