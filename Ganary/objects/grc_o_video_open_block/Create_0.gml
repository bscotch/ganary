event_inherited()
started_already = false;
show_debug_message("Will complete the test in 2 seconds.");
call_later(2, time_source_units_seconds, function(){
	olympus_test_resolve();
	instance_destroy();    
});