function grc_register_async_user_feedback_tests(){
	olympus_add_async_test_with_user_feedback("shader_test", "Did the sprite flash?", function(){
		return grc_instance_create(grc_o_shader_test);
	})
	
	olympus_add_async_test_with_user_feedback("audio_test", "Did you hear a bleep sound?",function(){
		return grc_instance_create(grc_o_audio_functions_test);
	})

	if os_type == os_uwp{
		olympus_add_async_test_with_user_feedback("show_message_test", "Did a dialogue box appear?", function(){
			show_message("Successfully prompted a dialogue. Close this dialogue box now.");
			return grc_instance_create(grc_o_helper_async);
		})				
	}
	
	switch os_type{
		case os_windows:
		case os_macosx:
		case os_linux:
		case os_ios:
		case os_android:
		case os_xboxone:
			var url = "http://localhost/%20&this=that"
			olympus_add_async_test_with_user_feedback("url_open_test", "Url should be exactly: " + url, function(){
				var url = "http://localhost/%20&this=that"
				url_open(url);
				return grc_instance_create(grc_o_helper_async);
			})		
			break;
	}
}