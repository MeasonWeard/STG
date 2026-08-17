if (setScale) {

	var panelW = sprite_width;
	var panelH = sprite_height;

	var availableW = panelW - pad * 2;
	var availableH = panelH - pad * 2 - titleH;

	var portraitW = sprite_get_width(portrait);
	var portraitH = sprite_get_height(portrait);

	var scaleX = availableW / portraitW;
	var scaleY = availableH / portraitH;

	scale = min(scaleX, scaleY);

	portraitX = x;
	portraitY = y + pad + titleH + availableH * 0.5;
	
	draw_set_font(fnt_huge);
	
	var ex = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	titleH = string_height(ex) * 1.25;
	
	var drawW = portraitW * scale;
	var drawH = portraitH * scale;
	
	borderLeft   = portraitX - drawW * 0.5;
	borderRight  = portraitX + drawW * 0.5;
	borderTop    = portraitY - drawH * 0.5;
	borderBottom = portraitY + drawH * 0.5;

}