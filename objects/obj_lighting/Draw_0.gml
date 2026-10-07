var col = c_white;
var a = alpha;

var smoothness = clamp(transitionSmoothness, 0, 1);

//colours
var colLen = array_length(cols);

if (colLen > 0) {

    var index1 = floor(colPos);
    var index2 = (index1 + 1) mod colLen;

    var t = frac(colPos);

    if (smoothness <= 0) {
        t = 0;
    } else {
        t = clamp((t - (1 - smoothness) * 0.5) / smoothness, 0, 1);
    }

    col = merge_color(cols[index1], cols[index2], t);

}

//alphas
var alphaLen = array_length(alphas);

if (alphaLen > 0) {

    var index1 = floor(alphaPos);
    var index2 = (index1 + 1) mod alphaLen;

    var t = frac(alphaPos);

    if (smoothness <= 0) {
        t = 0;
    } else {
        t = clamp((t - (1 - smoothness) * 0.5) / smoothness, 0, 1);
    }

    a = lerp(alphas[index1], alphas[index2], t);

}

draw_set_alpha(a);
draw_set_color(col);

draw_rectangle(camX - pad, camY - pad, camX + camW + pad, camY + camH + pad, false);

draw_set_alpha(1);
draw_set_color(c_white);