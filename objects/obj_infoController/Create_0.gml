global.infoController = self;

page1Text = scr_file_getTextFromFile("infoControls");
page2Text = scr_file_getTextFromFile("infoCore");
page3Text = scr_file_getTextFromFile("infoOADA");
page4Text = scr_file_getTextFromFile("infoDamage");
page5Text = scr_file_getTextFromFile("infoResistances");

text = [page1Text, page2Text, page3Text, page4Text, page5Text];

pageIndex = 0;
pages = array_length(text);


xx = x + sprite_width * 0.5;