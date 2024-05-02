/// @description Insert description here
// You can write your code in this editor
if device_mouse_check_button_pressed(0, mb_any){
	click_count++;
}	

if click_count >= 5{
	olympus_test_resolve();
	instance_destroy();
}