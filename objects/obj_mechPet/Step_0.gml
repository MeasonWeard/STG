event_inherited();

if (spawning) exit;
	
if (teleportToOwner and instance_exists(owner)) {

	teleportToOwner = false;

	x = owner.x;
	y = owner.y;
	
}
	
scr_ai_standardPetBehaviour();
scr_char_animateLRMirror(false);