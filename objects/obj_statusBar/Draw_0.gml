var xx1;
var yy1;
var xx2;
var yy2;

var prevCol = draw_get_colour();

if (drawByCoordinates) {
	
    xx1 = left;
    yy1 = top;
    xx2 = right;
    yy2 = bottom;
	
} else {
	
    xx1 = x - width * 0.5;
    yy1 = y - height * 0.5;
    xx2 = x + width * 0.5;
    yy2 = y + height * 0.5;
	
}

var barW = xx2 - xx1;
var barH = yy2 - yy1;

var perc = 0;
if (maxValue > 0) perc = clamp(value / maxValue, 0, 1);

//background
draw_set_alpha(backAlpha);
draw_set_color(backCol);

draw_rectangle(
    xx1,
    yy1,
    xx2,
    yy2,
    false
);

//fill
var fillW = (barW - borderSize * 2) * perc;

var fx1;
var fx2;

if (leftToRight) {
    fx1 = xx1 + borderSize;
    fx2 = fx1 + fillW;
} else {
    fx2 = xx2 - borderSize;
    fx1 = fx2 - fillW;
}

draw_set_alpha(fillAlpha);
draw_set_color(fillCol);

draw_rectangle(
    fx1,
    yy1 + borderSize,
    fx2,
    yy2 - borderSize,
    false
);

//border
draw_set_alpha(borderAlpha);
draw_set_color(borderCol);

for (var i = 0; i < borderSize; i++) {
	
    draw_rectangle(
        xx1 + i,
        yy1 + i,
        xx2 - i,
        yy2 - i,
        true
    );
	
}

//text
if (is_string(txt) and txt != "") {

	draw_set_halign(fa_middle);
	draw_set_valign(fa_middle);
	draw_set_colour(txtCol);
	
	draw_set_font(font);
	
	draw_text(x, y, txt);
	
	scr_misc_resetTextAlignment();
	
}

draw_set_alpha(1);
draw_set_color(prevCol);