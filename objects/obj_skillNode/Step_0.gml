scr_obj_mouseHover();

if (mouseHover) {

	var txt = "";
	if (is_struct(thisSkill)) txt = thisSkill.name;
	txt += "   lvl " + string(thisSkill.level);
	scr_ui_mouseHoverText(string(txt), fnt_normal);
	

	if (mouse_check_button_pressed(mb_left)) {
		thisSkill.level ++;
	}
	
	if (mouse_check_button_pressed(mb_right)) {
		thisSkill.level --;
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
			if (skills.skill3key == thisSkill.key) skills.skill3 = undefined;	
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