draw_self();

var txt = "";
var totalPoints = c.totalPoints;
var points = c.points;

txt = "Skill points:   " + string(points) + " / " + string(totalPoints);

draw_set_font(fnt_large);
draw_set_colour(c_blue);
draw_text(x + 12, y + 12, txt);

draw_set_halign(fa_middle);
draw_text(titleX, titleY, titleTxt);