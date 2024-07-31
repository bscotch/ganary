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

	switch os_type{
		case os_windows:
		case os_macosx:
		case os_linux:
		case os_ios:
		case os_android:
			olympus_add_async_test_with_user_feedback("mouse_or_touch_or_keyboard_test", "Did the keyboard/mouse/touch input register?",function(){
				return grc_instance_create(grc_o_mouse_keyboard_test);
			});
		case os_switch:
		case os_xboxseriesxs:
			olympus_add_async_test_with_user_feedback("controller_test", "Did the controller input register?",function(){
				return grc_instance_create(grc_o_controller_test);
			});	
		break;
	}

	olympus_add_async_test_with_user_feedback("video_resume_test", "Please pause the game by going to anther app, come back to the game, and see if the video resumes playing", function(){
		//https://github.com/YoYoGames/GameMaker-Bugs/issues/7035
		return grc_instance_create(grc_o_video_resume_test);
	})
	
	olympus_add_test("video_resume_test_cleanup", function(){
		with grc_o_video_resume_test{
			instance_destroy();
		}
	})
}