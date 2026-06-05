event_inherited();

if (instance_exists(cursor)) {
	
	aimX = cursor.x;
	aimY = cursor.y;

}

//gun
var shooting = false;

if (is_struct(gun)) {
	shooting = gun.auto? mouse_check_button(mb_left) : mouse_check_button_pressed(mb_left);
}

if (shooting) {

	if (meleeCooldown == 0) {
		
		var proj = scr_guns_shoot(self);
		if (instance_exists(proj)) proj.charHitReport = true;
		
	}
	
}

if (keyboard_check_pressed(ord("R"))) {

	if (is_struct(gun) and !gun.temporary and gun.reload == 0) scr_guns_reload(gun);
	
}

//select guns
if(mouse_check_button_pressed(mouse_wheel_up())) gunIndex ++;
if(mouse_check_button_pressed(mouse_wheel_down())) gunIndex --;

var gunsLen = array_length(guns);
if (gunIndex < 0) gunIndex = gunsLen - 1;
if (gunIndex >= gunsLen) gunIndex = 0;

if (gunsLen > 0) {
	
	gun = guns[gunIndex];
	
} else {

	gun = undefined;
	
}

//melee 
if(mouse_check_button(mb_right)) {
	
	var attack = scr_melee_attack(self);
	
}