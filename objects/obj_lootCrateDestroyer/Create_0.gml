player = global.player;

crates = [];

countDown = 128;

destroyTick = 0;
destroyIndex = 0;

moveSpd = 32;
spinSpd = 1.75;

pulse = 1;
pulseDir = 1;
ringDir = 0;

with (obj_lootCrateGeneric) {
	array_push(other.crates, self);
}

with (obj_lootCrateBetter) {
	array_push(other.crates, self);
}

with (obj_lootCrateSuper) {
	array_push(other.crates, self);
}

cratesLen = array_length(crates);

array_shuffle_ext(crates);