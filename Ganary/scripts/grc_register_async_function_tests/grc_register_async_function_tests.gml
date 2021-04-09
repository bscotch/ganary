function grc_register_async_function_tests(){
	if !debug_mode{
		olympus_add_async_test("garbage_collection_test", function(){
			return grc_instance_create(grc_o_garbage_collection_test);
		})
	}

	if grc_internet_required{
		olympus_add_async_test("http_delete_receiver_test", function(){
			return grc_instance_create(grc_o_http_buffer_delete_test);
		})
		
		olympus_add_async_test("http_request_buffer_body_test", function(){
			return grc_instance_create(grc_o_http_request_buffer_body_test);
		})
	}

	olympus_add_async_test("async_saveload_test", function(){
		return grc_instance_create(grc_o_async_saveload_test);
	})
	
	olympus_add_async_test("controller_function_test", function(){
		return grc_instance_create(grc_o_gamepad_functions_test);
	})
	
	olympus_add_async_test("room_functions_test", function(){
		return grc_instance_create(grc_o_room_functions_test);
	})
	
	olympus_add_async_test("keyboard_function_test", function(){
		return grc_instance_create(grc_o_keyboard_functions_test);
	})
	
	olympus_add_async_test("array_reference_test", function(){
		return grc_instance_create(grc_o_array_reference_test);
	})

}