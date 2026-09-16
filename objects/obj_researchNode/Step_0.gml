scr_obj_mouseHover();

if (mouseHover) {
	
	if (is_undefined(desc)) {
	
		desc = scr_research_formatDescription(project);
	
	}
	
	scr_ui_mouseHoverText(desc, fnt_normal);

	if (mouse_check_button_pressed(mb_left)) {

		rc.viewedNode = self;
		rc.viewedProject = project;
	
	}

}

var key = is_struct(project) ? project.key : undefined;
var currentKey = global.gameData.research.currentResearch;
isCurrent = key == currentKey;