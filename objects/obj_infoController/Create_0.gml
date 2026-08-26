global.infoController = self;

page1Text = scr_file_getTextFromFile("infoPage1");
page2Text = scr_file_getTextFromFile("infoPage2");
page3Text = scr_file_getTextFromFile("infoPage3");
page4Text = scr_file_getTextFromFile("infoPage4");

text = [page1Text, page2Text, page3Text, page4Text];

pageIndex = 0;
pages = array_length(text);
 