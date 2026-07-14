var prevCol = draw_get_colour();
var prevFont = draw_get_font();

if (active) {
	
	draw_self();
	
} else if (visibleWhenInactive) {
	
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_grey, image_alpha);	
	
} else {

	exit;
	
}

var col = active? textCol : c_black;

//clicky clicky
if (mouseHover) {

	image_index = 1;
	col = hoverCol;
	
	if (toolTipTxt != undefined and toolTipTxt != "") {
	
		//scr_obj_drawTooltip(toolTipTxt, toolTipSide);
	
	}
	
} else {
	
	image_index = 0;
	
}

if (clicked) clickFlash = clickFlashTime;

if (clickFlash > 0) {
	
	clickFlash --;
	image_index = 2;
	col = clickCol;
	
}

//text
draw_set_colour(col);
draw_set_halign(fa_middle);
draw_set_valign(fa_center);

draw_text(x, y, txt);

scr_misc_resetTextAlignment();
draw_set_colour(prevCol);
draw_set_font(prevFont);

//icon
if (icon != undefined) {

	draw_sprite(icon, image_index, x, y);
	
}