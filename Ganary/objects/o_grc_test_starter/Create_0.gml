url_to_send_output_to = "http://192.168.1.98:4000"
_should_resume_record = true;

_function_to_add_tests_and_hooks = function() {
	grc_register_sync_function_tests();
	grc_register_async_function_tests();
	grc_register_async_user_feedback_tests();
	grc_register_compile_tests();
	
	olympus_add_hook_after_suite_finish( function(summary){ 
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
		var map = ds_map_create();	
		ds_map_add(map, "Content-Type", "application/json");
		http_request(url_to_send_output_to, "POST", map,  json_stringify(summary));
		ds_map_destroy(map);
	});
}

_start_test = function(){
	olympus_run("grc_test", _function_to_add_tests_and_hooks, {
		resume_previous_record: _should_resume_record, 
		skip_user_feedback_tests: debug_mode || os_get_config() == "dev"
	});
	instance_destroy();
}

if debug_mode || os_get_config() == "dev"{
	_should_resume_record = false;
	_start_test();
}
else{
	_count_down_timer = 3;
}