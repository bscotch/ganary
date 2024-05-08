global._should_resume_record = true;
if os_type == os_android{
	_olympus_android_init();
	var intent = _olympus_android_get_intent();
	var is_test_loop = string_count("TEST_LOOP", intent) > 0
	if (is_test_loop) {
		global.olympus_headless = true;
	}
}
else if os_type == os_ios{
	var intent = _olympus_ios_get_intent();
	var is_test_loop = string_count("firebase-game-loop", intent) > 0;
	if (is_test_loop) {
		global.olympus_headless = true;
	}
}

_function_to_add_tests_and_hooks = function() {
	grc_register_sync_function_tests();
	grc_register_async_function_tests();
	grc_register_async_user_feedback_tests();
	grc_register_compile_tests();
	
	olympus_add_hook_after_suite_finish( function(summary){ 
		if global.olympus_headless {
			if os_type == os_ios{
				_olympus_ios_finish_loop();	
			}
			else if os_type == os_android{
				_olympus_android_game_end();
			}
			else {
				game_end();
			}		
		}
		else{
			with grc_instance_create(o_grc_test_end_result) {			
				if summary.tallies.failed > 0 || 
					summary.tallies.crashed >0{
						res_color = c_red;
						test_message = "Some tests failed or crashed";
					}
				else if summary.tallies.skipped > 0{
					res_color = c_orange;
					test_message = "Some tests were skipped";
				}
			}
		}
	});
}


_start_test = function(){
	olympus_run(_function_to_add_tests_and_hooks, {
		olympus_suite_options_skip_user_feedback_tests : debug_mode || os_get_config() == "dev" || global.olympus_headless,	
		olympus_suite_options_ignore_if_completed: !debug_mode && !(os_get_config() == "dev"),
		olympus_suite_options_abandon_unfinished_record: !global._should_resume_record,
		olympus_suite_options_description: "CI test"
	});
	instance_destroy();
}

if debug_mode || os_get_config() == "dev" || global.olympus_headless{
	global._should_resume_record = false;
	_start_test();
}
else{
	_count_down_timer = 3;
}