x = mouse_x;
y = mouse_y;

if (instance_exists(player) and is_struct(player.gun)) {
	mode = "aim";	
} else {
	mode = "point";	
}