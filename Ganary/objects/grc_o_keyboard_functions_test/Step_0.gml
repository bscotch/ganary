event_inherited();
if active{
	grc_async_assert(keyboard_string,grc_keyboard_string_test_expected);
	timeout += 1/room_speed;
	if timeout > timeout_max{
		olympus_test_resolve();
		instance_destroy();
	}
}