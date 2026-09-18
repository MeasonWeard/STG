draw_self();

draw_set_font(fnt_large);
draw_set_colour(c_black);
scr_misc_resetTextAlignment();

//viewed node

if (instance_exists(viewedNode) and is_struct(viewedProject)) {
	
	if (is_undefined(viewedNode.desc)) {
	
		viewedNode.desc = scr_research_formatDescription(viewedProject);
	
	}
	
	if (is_undefined(viewedNode.cont)) {
	
		viewedNode.cont = scr_research_formatContributingResources(viewedProject);
	
	}
	
	draw_sprite(viewedNode.sprite_index, 0, iconX, iconY);
	
	draw_text(descX, descY, viewedNode.desc);
	
	draw_text(progX, progY - 64, "Progress:");
	scr_research_drawProgress(viewedProject, progX, progY, fnt_large);
	draw_text(progX, progY + 64, "Contributing Resources:");
	scr_research_drawContributingResources(viewedNode.cont, progX, progY + 128, fnt_large);
	
	
}

// researching

if (is_struct(currentProject)) {

	draw_set_font(fnt_large);
	draw_set_colour(c_black);
	scr_misc_resetTextAlignment();

	if (!is_undefined(currentIcon)) draw_sprite(currentIcon, 0, currentIconX, currentIconY);
	var lvl = currentProject.level + 1;
	draw_text(currentTextX, currentTextY, "Researching:   " + currentProject.name + "  -   level " + string(lvl));
	scr_research_drawProgress(currentProject, currentTextX + 16, currentTextY + 64, fnt_large);
	
}