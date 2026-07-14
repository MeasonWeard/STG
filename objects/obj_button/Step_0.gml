if (is_callable(constantFunc)) constantFunc();

if (!active) exit;

scr_obj_mouseHover();

var leftClick = is_callable(leftFunc) and (scr_obj_clicked(0, hold)); //or scr_input_check(leftKey, hold));
var rightClick = is_callable(rightFunc) and (scr_obj_clicked(1, hold)); //or scr_input_check(rightKey, hold));

clicked = leftClick or rightClick;

if (leftClick) method_call(leftFunc, leftArgs);
if (rightClick) method_call(rightFunc, rightArgs);

if (clickSound != undefined and playClickSound and leftClick or rightClick) {
	audio_play_sound(clickSound, 0, false);
	playClickSound = false;
}

if (!leftClick and !rightClick) playClickSound = true;