event_inherited()
if active{
	var clicked = false;

	if self_click_timer < self_click_timer_max{
		self_click_timer += 1/room_speed;
	}
	else{
		self_click_timer = 0;
		clicked = true;
	}

	if mouse_check_button_pressed(mb_left){
		clicked = true;
	}

	for (var i = 0; i < gamepad_get_device_count(); i++){
		if gamepad_button_check_pressed(i, gp_face1){
			clicked = true;
		}
	}

	if clicked {
		flash = 1;
		click_count ++;
	}

	if click_count > click_count_max{
		olympus_test_resolve();
		instance_destroy();
	}
}