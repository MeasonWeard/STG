gameData = global.gameData;

depth = layers.ui;

active = true;
visibleWhenInactive = true;

txt = "";
font = fnt_normal;
icon = undefined;

mouseHover = false;

leftFunc = undefined;
rightFunc = undefined;

leftKey = undefined;
rightKey = undefined;

clickSound = undefined;//snd_click1;
playClickSound = true;

constantFunc = undefined;

hold = false;

clicked = false;

clickFlash = 0;
clickFlashTime = 4;
image_speed = 0;

textCol = c_black;
hoverCol = c_lime;
clickCol = c_white;

toolTipSide = 0; //0 = top 1 = right 2 = bottom 3 = left
toolTipTxt = "";

setup = true;