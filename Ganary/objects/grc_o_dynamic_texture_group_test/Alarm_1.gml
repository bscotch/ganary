/// @description Insert description here
// You can write your code in this editor
var status = texturegroup_get_status("texgroup1");
if (status == texturegroup_status_fetched){
	grc_console_log("texgroup1 loading completed");
	olympus_test_resolve();
	instance_destroy();
}
else{
	alarm[1] = 5;
}