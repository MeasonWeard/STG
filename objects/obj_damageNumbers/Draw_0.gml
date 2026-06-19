var fnt;

switch(size) {
	
    case 0: fnt = fnt_smallBold; break;
	case 1: fnt = fnt_normalBold; break;
	case 2: fnt = fnt_largeBold; break;
	case 3: fnt = fnt_hugeBold; break;
	default: fnt = fnt_normalBold;
	
}

draw_set_valign(fa_middle);
draw_set_font(fnt);

draw_set_colour(c_black);
draw_text(x-1, y+1, num);
draw_set_colour(col);
draw_text(x, y, num);

scr_misc_resetTextAlignment();

y -= riseSpeed;