event_inherited()
started_already = false;
show_debug_message("Will complete the test in 2 seconds.");
game_set_speed(59, gamespeed_fps);
call_later(15, time_source_units_seconds, function(){
	olympus_test_resolve();
	instance_destroy();    
});