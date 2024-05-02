/// @desc controller support, mouse support, and count down
var gp_num = gamepad_get_device_count();
for (var i = 0; i < gp_num; i++;){
	if gamepad_is_connected(i){ 
		if gamepad_button_check_pressed(i, gp_face1){
			global._should_resume_record = false;
		}
	}
}

if (mouse_check_button_pressed(mb_left)){
	global._should_resume_record = false;
}

_count_down_timer -= 1/room_speed
if _count_down_timer <= 0 {
	_start_test();
}
