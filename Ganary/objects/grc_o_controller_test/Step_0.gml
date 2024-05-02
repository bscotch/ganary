/// @description Insert description here
// You can write your code in this editor
if device_mouse_check_button_pressed(0, mb_any){
	click_count++;
}	

var gp_num = gamepad_get_device_count();
for (var i = 0; i < gp_num; i++;)
{
    if (gamepad_is_connected(i))
    {
        if gamepad_button_check_pressed(i, gp_face1){
			click_count++;
		}
    }
}

if click_count >= 5{
	olympus_test_resolve();
	instance_destroy();
}

