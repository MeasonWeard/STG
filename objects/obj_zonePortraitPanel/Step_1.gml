if (setScale) {

	var panelW = sprite_width;
	var panelH = sprite_height;

	var availableW = panelW - pad * 2;
	var availableH = panelH - pad * 2;

	var portraitW = sprite_get_width(portrait);
	var portraitH = sprite_get_height(portrait);

	var scaleX = availableW / portraitW;
	var scaleY = availableH / portraitH;

	var drawW = portraitW * scale;
	var drawH = portraitH * scale;

	portraitX = x + panelW * 0.5;
	portraitY = y + panelH * 0.5;

	scale = min(scaleX, scaleY);

}