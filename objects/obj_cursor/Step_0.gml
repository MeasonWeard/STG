x = mouse_x;
y = mouse_y;

if (instance_exists(player) and is_instanceof(player.equippedWeapon, weaponInst)) {
	mode = "aim";	
} else {
	mode = "point";	
}