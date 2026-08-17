draw_self();

//draw portrait
draw_sprite_ext(
	portrait,
	0,
	portraitX,
	portraitY,
	scale,
	scale,
	0,
	c_white,
	1
);

//draw border
draw_set_colour(c_black);
draw_rectangle(borderLeft, borderTop, borderRight, borderBottom, true);
draw_rectangle(borderLeft - 1, borderTop -1, borderRight + 1, borderBottom + 1, true);

//draw heading
draw_set_colour(sr.titleCol);
draw_set_font(fnt_huge);
draw_set_halign(fa_middle);
draw_set_valign(fa_middle);
draw_text(x, y + 28, sr.zoneName);