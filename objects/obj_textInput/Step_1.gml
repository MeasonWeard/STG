if (setup) {

	setup = false;

	font = font ?? fnt_normal;

	draw_set_font(font);
	
	var txtExample = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
	var averageCharWidth = string_width(txtExample) / string_length(txtExample);
	
	h = string_height(txtExample);
	w = (averageCharWidth * maxLength) * 1.1 + pad * 2;

	height = max(height, h + pad * 2);
	width = max(width, w);
	
}