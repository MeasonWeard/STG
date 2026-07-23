function scr_genUnique_funnyHammer(level){

	var hammer = scr_genMelee_hammer(level, -1);

	hammer.attackRate = 4;
	hammer.name = "Funny Hammer";
	
	return hammer;

}