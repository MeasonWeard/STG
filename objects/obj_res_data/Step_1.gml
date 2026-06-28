// Inherit the parent event
event_inherited();

if(setupRank) {

	setupRank = false;
	
	rank = 0;
	var v = val;

	while (v > 8 and rank < image_number - 1) {
	    v = v div 2;
	    rank++;
	}
	
	image_index = rank;
	
}