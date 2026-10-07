depth = layers.lighting;

var len = array_length(cols);

if (len > 0) {

    var index1 = floor(transitionPos);
    var index2 = (index1 + 1) mod len;

    var t = frac(transitionPos);

    var smoothness = clamp(transitionSmoothness, 0, 1);

    if (smoothness <= 0) {
        t = 0;
    } else {
        t = clamp((t - (1 - smoothness) * 0.5) / smoothness, 0, 1);
    }

    var col = merge_color(cols[index1], cols[index2], t);

    draw_set_alpha(alpha);
    draw_set_color(col);
	
    draw_rectangle(camX - pad, camY - pad, camX + camW + pad, camY + camH + pad, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
	
}