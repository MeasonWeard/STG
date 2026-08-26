draw_set_font(fnt_normal);

var pad = 20;

var txt = "";

if (tab == "core") {
	
	txt = "CORE STATS\n\n" + txtCore;	
	
} else if (tab == "defense") {
	
	txt = "DEFENSE STATS\n\n" + txtDef;	
	
} else if (tab == "offense") {
	
	txt = "OFFENSE STATS\n\n" + txtOff;
	
}

var tabTxt = string(tabIndex + 1) + " / " + string(array_length(tabs)) + "   ";
tabTxt += "\n< Press Tab >";

scr_misc_resetTextAlignment();

draw_set_colour(data.colours.windowBackground);
draw_rectangle(statsLeft, statsTop, statsRight, statsBottom, false);
draw_set_colour(c_black);
draw_rectangle(statsLeft, statsTop, statsRight, statsBottom, true);

draw_set_colour(data.colours.windowText);
draw_text(statsLeft + pad, statsTop + pad, txt);

draw_set_halign(fa_right);
draw_text(statsRight - pad, statsTop + pad, tabTxt);

