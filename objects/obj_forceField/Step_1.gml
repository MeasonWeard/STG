if (setup) {

	setup = false;

	if (instance_exists(owner)) {
		
		scr_char_addStatMod(owner, "da", da, life, "forceFieldDA");
		scr_char_addStatMod(owner, "projRes", projRes, life, "forceFieldProjRes");
		scr_char_addStatMod(owner, "meleeRes", meleeRes, life, "forceFieldMeleeRes");
	
	}

}