/// @description Insert description here
// You can write your code in this editor
var zoom_amt = 1;
try{
	var view_diff_raw	= anchor_blackbar_lerp*(camera_get_view_width(view_camera[0])-(zoom_amt*base_width));
}
catch(err){
	olympus_test_reject(err);
	instance_destroy();
	return;
}
olympus_test_resolve();
instance_destroy();