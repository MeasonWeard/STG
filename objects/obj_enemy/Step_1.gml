// Inherit the parent event
event_inherited();

if (aiSetup) {

	aiSetup = false;
	ghostCheckIndex = scr_timeSlicing_assignTurnIndex("ghostCheck");
	
	shootDelayTick = irandom_range(shootDelayMin * 2, shootDelayMax * 2);
	
	aimIndex = scr_timeSlicing_assignTurnIndex("aim");
	
}