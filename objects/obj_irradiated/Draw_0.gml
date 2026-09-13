event_inherited();

pulse += pulseSpeed * pulseDir;

if (pulse >= maxPulse) {
	pulse = maxPulse;
	pulseDir = -1;
}

if (pulse <= minPulse) {
	pulse = minPulse;
	pulseDir = 1;
}

draw_set_colour(c_purple);
draw_set_alpha(0.65);
draw_circle(x, y, pulse, false);

draw_set_alpha(1);