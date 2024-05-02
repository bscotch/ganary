test_CURSOR_LAST_X = round(device_mouse_x_to_gui(0));
test_CURSOR_LAST_Y = round(device_mouse_y_to_gui(0));
cursor_last_click_x = "0";
cursor_last_click_y = "0";
click_count = 0;
reset_count = call_later(3, time_source_units_seconds, function(){ 
	click_count = 0;
}, true)


exiting_call = time_source_create(time_source_game ,300, time_source_units_seconds, function(){
	olympus_test_resolve();
	instance_destroy();
})
time_source_start(exiting_call)