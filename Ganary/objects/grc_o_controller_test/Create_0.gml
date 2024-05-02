should_turn_on_debug_overlay = false;
if is_debug_overlay_open(){
	should_turn_on_debug_overlay = true;
	show_debug_overlay(false);
}
click_count = 0;
reset_count = call_later(3, time_source_units_seconds, function(){ 
	click_count = 0;
}, true)


exiting_call = time_source_create(time_source_game ,300, time_source_units_seconds, function(){
	olympus_test_resolve();
	instance_destroy();
})
time_source_start(exiting_call)


if os_type == os_switch {
	/// @description Start Controller Support App
	switch_controller_set_supported_styles(switch_controller_handheld | switch_controller_joycon_dual | switch_controller_pro_controller | switch_controller_joycon_left | switch_controller_joycon_right );
	switch_controller_joycon_set_holdtype(switch_controller_joycon_holdtype_horizontal);

	// Ensure that the handheld requires both joy-cons connected to be active.
	switch_controller_set_handheld_activation_mode(switch_controller_handheld_activation_dual);

	switch_controller_support_set_defaults();
	switch_controller_support_set_singleplayer_only(true);
	switch_controller_support_show();
}

discover_gamepad = function(pad_index){
	// Lets see if we already have one - as Joy-Con Duals can come in as *two* connect events
	var instCount = instance_number(grc_o_controller);
	var controller = undefined;
	for (var i = 0; i < instCount; ++i) {
		var iController = instance_find(grc_o_controller, i);
		if (iController.mPadId == pad_index) {
			controller = iController;
			break;
		}
	}

	var deviceType = gamepad_get_description(pad_index);
	show_debug_message("New Gamepad [" + string(pad_index) + "] - " + deviceType);
	

	if (undefined != controller) { // we already have a controller, check if it's a Joy-Con Dual and we've just connected half
		if ("Joy-Con" == deviceType && switch_controller_joycon_dual == controller.mType) {
			controller.mJoyCons[@ 0] = switch_controller_joycon_left_connected(pad_index);
			controller.mJoyCons[@ 1] = switch_controller_joycon_right_connected(pad_index);
			exit;
		}
	}	
	
	var controller = instance_create_depth(x, y, 0, grc_o_controller);
	controller.mPadId = pad_index;
	

	switch (deviceType) {
		case "Handheld": controller.mType = switch_controller_handheld; break;
		case "Joy-Con (L)": controller.mType = switch_controller_joycon_left; break;
		case "Joy-Con (R)":	controller.mType = switch_controller_joycon_right; break;
		case "Pro Controller": controller.mType = switch_controller_pro_controller; break;
		case "Joy-Con": {
			controller.mType = switch_controller_joycon_dual;
			controller.mJoyCons[@ 0] = switch_controller_joycon_left_connected(pad_index);
			controller.mJoyCons[@ 1] = switch_controller_joycon_right_connected(pad_index);
		};
		break;
	}	
}

var gp_num = gamepad_get_device_count();
for (var i = 0; i < gp_num; i++;)
{
    if (gamepad_is_connected(i))
    {
        discover_gamepad(i);
    }
}