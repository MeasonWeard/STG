event_inherited();

if (global.debug and keyboard_check_pressed(ord("G"))) {

	show_debug_message(gunStats);

	var len = array_length(guns);
	
	for (var i = 0; i < len; i ++) {
	
		var slot = guns[i];
		
		if (is_struct(slot)) {
		
			show_debug_message(slot.stats);
		
		}
	
	}
	
}

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

	if (is_struct(gun) and !gun.temporary and gun.reload == 0) scr_guns_reloadCurrent(self);
	
}

//select guns
var prevIndex = gunIndex;

if(mouse_check_button_pressed(mouse_wheel_up())) gunIndex ++;
if(mouse_check_button_pressed(mouse_wheel_down())) gunIndex --;

if (gunIndex != prevIndex) {

	var gunsLen = array_length(guns);
	if (gunIndex < 0) gunIndex = gunsLen - 1;
	if (gunIndex >= gunsLen) gunIndex = 0;

	if (gunsLen > 0) {
	
		scr_guns_equipGun(self, gunIndex);
	
	} else {

		gun = undefined;
	
	}

}

//melee 
if(mouse_check_button(mb_right)) {
	
	var attack = scr_melee_attack(self);
	
}

//skills
var skill1 = skills.skill1;
var skill2 = skills.skill2;
var skill3 = skills.skill3;
var skill4 = skills.skill4;

if (keyboard_check(ord("1")) and is_struct(skill1)) skill1.cast(self);
if (keyboard_check(ord("2")) and is_struct(skill2)) skill2.cast(self);
if (keyboard_check(ord("3")) and is_struct(skill3)) skill3.cast(self);
if (keyboard_check(ord("4")) and is_struct(skill4)) skill4.cast(self);