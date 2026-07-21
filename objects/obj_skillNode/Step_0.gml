scr_obj_mouseHover();

if (mouseHover) {

	var txt = "";
	if (is_struct(thisSkill)) txt = thisSkill.name;
	txt += "   lvl " + string(thisSkill.level);
	scr_ui_mouseHoverText(string(txt), fnt_normal);
	
	if (global.debug) {
		
		///FREE POINTS!
		if (mouse_check_button_pressed(mb_left)) {
			thisSkill.level ++;
		}
	
		if (mouse_check_button_pressed(mb_right)) {
			thisSkill.level --;
		}
	
	} else {
		
		//the proper way
		if (mouse_check_button_pressed(mb_left)) {
			
			if (c.points > 0) {
				
				var success = true;
				
				thisSkill.level ++;
				
				if (thisSkill.level > thisSkill.maxLevel) {
					thisSkill.level = thisSkill.maxLevel;
					success = false;
				}
				
				if (success) {
					
					c.points --;
				
					if (thisSkill.active) {

					    var slots = ["skill1", "skill2", "skill3", "skill4"];
					    var alreadyAssigned = false;

					    // First check whether this skill is already assigned
					    for (var i = 0; i < array_length(slots); i++) {

					        var slot = variable_struct_get(playerData.skills, slots[i]);

					        if (is_struct(slot) and slot.key == thisSkill.key) {
					            alreadyAssigned = true;
					            break;
					        }

					    }

					    // Only look for an empty slot if it was not found
					    if (!alreadyAssigned) {

					        var skillStruct = {
					            key: thisSkill.key,
					            icon: thisSkill.icon
					        };

					        for (var i = 0; i < array_length(slots); i++) {

					            var slotKey = slots[i];
					            var slot = variable_struct_get(playerData.skills, slotKey);

					            if (is_undefined(slot)) {
					                variable_struct_set(playerData.skills, slotKey, skillStruct);
					                break;
					            }

					        }

					    }

					}
				
				}
				
			}
			
		}
	
		if (mouse_check_button_pressed(mb_right)) {
			
			if (thisSkill.level > 0) {
				thisSkill.level --;
				c.points = min(c.totalPoints, c.points + 1);
			}
			
		}
		
	}
	
	//clear invalid active skills
	if (thisSkill.level < 1) {
		
		var skills = playerData.skills;
		
		thisSkill.level = 0;
		
		if (is_struct(skills.skill1)) {
			if (skills.skill1.key == thisSkill.key) skills.skill1 = undefined;	
		}
		
		if (is_struct(skills.skill2)) {
			if (skills.skill2.key == thisSkill.key) skills.skill2 = undefined;	
		}
		
		if (is_struct(skills.skill3)) {
			if (skills.skill3.key == thisSkill.key) skills.skill3 = undefined;	
		}
		
		if (is_struct(skills.skill4)) {
			if (skills.skill4.key == thisSkill.key) skills.skill4 = undefined;	
		}
		
	}
	
	//assign to keys
	if (is_struct(thisSkill) and thisSkill.active) {
	
		var skillStruct = {
			key : thisSkill.key,
			icon: thisSkill.icon
		}
	
		if (keyboard_check_pressed(ord("1"))) playerData.skills.skill1 = skillStruct;
		if (keyboard_check_pressed(ord("2"))) playerData.skills.skill2 = skillStruct;
		if (keyboard_check_pressed(ord("3"))) playerData.skills.skill3 = skillStruct;
		if (keyboard_check_pressed(ord("4"))) playerData.skills.skill4 = skillStruct;
		
	}
	
}