draw_set_colour(c_lime);
draw_set_font(fnt_huge);
draw_set_halign(fa_middle);
draw_set_valign(fa_middle);

if (tab == "quit") {



	var txt = "Are you sure?";
	txt += "\n\nResources, XP and loot will be saved, but your progress through this stage will be lost.";
	txt += "\nIf you return later, a new stage will be generated and you'll start from the beginning.";

	draw_text(camXmid, yesButton.y - 192, txt);
	
}

if (tab == "main") {

	var txt = "Game Paused";
	draw_text(camXmid, continueButton.y - 128, txt);
	
}