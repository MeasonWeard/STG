if (unspentPoints and sc.hub) scr_ui_displayInstructions("You have unspent skill points", 300);

if (keyboard_check_pressed(ord("M"))) bigMap = !bigMap;
if (bigMap and keyboard_check_pressed(vk_escape)) bigMap = false;