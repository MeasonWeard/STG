if (!active) exit;

event_inherited();

if (instance_exists(cursor)) {
	
	aimX = cursor.x;
	aimY = cursor.y;

}

//ATTACKING
if (attackDelay > 0) attackDelay --;

//gun
if (is_instanceof(equippedWeapon, gunInst) and !attackDelay > 0) {

	var shooting = equippedWeapon.auto? mouse_check_button(mb_left) : mouse_check_button_pressed(mb_left);

	if (shooting) {

		var proj = scr_guns_shoot(self);
		if (instance_exists(proj)) {
			proj.charHitReport = true;
			shootingTick = shootingCooldown;
		}

	}

}

if (keyboard_check_pressed(ord("R"))) {

	if (is_instanceof(equippedWeapon, gunInst) and !equippedWeapon.temporary and equippedWeapon.reload == 0) scr_guns_reloadCurrent(self);
	
}

//melee 
if (is_instanceof(equippedWeapon, meleeInst) and !attackDelay > 0) {
	
	if(mouse_check_button(mb_left)) {
	
		var attack = scr_melee_attack(self);
	
	}
	
}


//select weapons
var prevIndex = weaponIndex;

if(mouse_check_button_pressed(mouse_wheel_up())) weaponIndex ++;
if(mouse_check_button_pressed(mouse_wheel_down())) weaponIndex --;

if (weaponIndex != prevIndex) {

	var weaponsLen = array_length(weapons);
	if (weaponIndex < 0) weaponIndex = weaponsLen - 1;
	if (weaponIndex >= weaponsLen) weaponIndex = 0;

	if (weaponsLen > 0) {
	
		scr_weapons_equipWeapon(self, weaponIndex);
	
	} else {

		equippedWeapon = undefined;
	
	}

}

//skills
var skill1 = skills.skill1;
var skill2 = skills.skill2;
var skill3 = skills.skill3;
var skill4 = skills.skill4;

if ((keyboard_check(ord("1")) or mouse_check_button(mb_right)) and is_struct(skill1)) skill1.cast(self);
if ((keyboard_check(ord("2")) or mouse_check_button(mb_side1)) and is_struct(skill2)) skill2.cast(self);
if ((keyboard_check(ord("3")) or mouse_check_button(mb_side2)) and is_struct(skill3)) skill3.cast(self);
if (keyboard_check(ord("4")) and is_struct(skill4)) skill4.cast(self);

//portal
if (!sc.hub and keyboard_check_pressed(ord("T"))) {
	
	var pt = scr_randomPointInCircleMinDist(x, y, 60, 20);
	
	var xx = pt.xx;
	var yy = pt.yy;
	
	scr_obj_createPortal(xx, yy);
	
}

//packs
var healed = 0;
var recharged = 0;

if (keyboard_check_pressed(ord("Q"))) healed = scr_char_useStimPack(self);
if (healed != 0) audio_play_sound(snd_medkit, 0, false);


if (keyboard_check_pressed(ord("E"))) recharged = scr_char_useEnergyPack(self);
if (recharged != 0) audio_play_sound(snd_recharge, 0, false);

if (instance_number(obj_statsPlate) == 0 and (keyboard_check_pressed(vk_tab) or keyboard_check_pressed(ord("C")))) {
	//scr_testSound();
	var sp = instance_create_layer(x, y, "Instances", obj_statsPlate);
	sp.owner = self;
}

//items
var pullRange = sc.stageInProgress ? ITEM_PULL_RANGE : 5000;
var pullStrength = sc.stageInProgress ? ITEM_PULL_STRENGTH : ITEM_PULL_STRENGTH * 2;
var hashRange = sc.stageInProgress ? 2 : 30;

var nearbyItems = scr_hash_getNearbyRange(global.stageController.itemHash, x, y, hashRange);
var len = array_length(nearbyItems);

for (var i = 0 ; i < len; i ++) {

	var item = nearbyItems[i];
	
	if (!instance_exists(item)) continue;
	
	var canCollect = (!is_callable(item.collectRequirements) or item.collectRequirements(self)) and item.collectDelay < 1; 
		
	var dist = point_distance(x, y, item.x, item.y);
	
	if (canCollect and dist <= pullRange) {
		
	    var t = 1 - dist / pullRange;

	    item.pullX = x;
	    item.pullY = y;
		item.pullSpd = max(1, (pullStrength * sqr(t)) * 2);
		
	}
	
	
	if (dist <= COLLECTION_RANGE) {
		
		scr_items_collect(self, item);
		
	}
	
}

//alternate use
if (keyboard_check(ord("C"))) alternateUse = true;