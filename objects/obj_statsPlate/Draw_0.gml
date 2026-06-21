camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);

scr_misc_resetTextAlignment();

draw_set_colour(c_dkgrey);
draw_rectangle(camX + 20, camY + 20, camX + 900, camY + 800, false);
draw_set_colour(c_black);
draw_rectangle(camX + 20, camY + 20, camX + 900, camY + 800, true);

draw_set_colour(c_lime);
draw_text(camX + 40, camY + 40, txt);