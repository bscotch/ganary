// Inherit the parent event
event_inherited();

if grc_gamepad_required{
	grc_async_assert(gamepad_is_supported(),true,"Game requires gamepad but platform does not support gamepad");
}
else{
	if !gamepad_is_supported(){
		olympus_test_resolve();
		instance_destroy();
	}
}

