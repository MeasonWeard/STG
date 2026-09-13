// Inherit the parent event
event_inherited();

sounds = [snd_irradiated];

image_alpha = 0;

minPulse = 8;
maxPulse = 16;
pulseSpeed = 0.33;
pulse = random_range(minPulse, maxPulse);
pulseDir = choose(-1, 1);