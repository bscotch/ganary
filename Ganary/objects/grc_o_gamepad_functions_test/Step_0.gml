event_inherited()
if active{
	for (var i = 0; i < 12; i++){
		if gamepad_is_connected(i){
			for (var j = 0; j < ds_list_size(buttons_to_test); j++){
				var dead_zone_max = .3;
				grc_expect_eq(gamepad_button_check(i,buttons_to_test[|j]),false,"Should not detect gamepad input for button " + string(buttons_to_test[|j]) + " for controller " + string(i));
				grc_expect_lt(gamepad_axis_value(i, gp_axislh),dead_zone_max,"Should not detect larger than dead_zone_max gamepad axis input for controller " + string(i))
				grc_expect_lt(gamepad_axis_value(i, gp_axislv),dead_zone_max,"Should not detect larger than dead_zone_max gamepad axis input for controller " + string(i))
				grc_expect_lt(gamepad_axis_value(i, gp_axisrh),dead_zone_max,"Should not detect larger than dead_zone_max gamepad axis input for controller " + string(i))
				grc_expect_lt(gamepad_axis_value(i, gp_axisrv),dead_zone_max,"Should not detect larger than dead_zone_max gamepad axis input for controller " + string(i))			
			}
		}
	}

	timeout += 1/room_speed;
	if timeout > timeout_max{
		olympus_test_resolve();
		instance_destroy();
	}
}
