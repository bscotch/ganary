/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
texturegroup_set_mode(true);
var status = texturegroup_get_status("texgroup1");
grc_expect_true(status != texturegroup_status_fetched, "texgroup1 is dynamic and should not have been automatically loaded");
var _loaded = texturegroup_load("texgroup1");
var _expected = 0;
if GM_runtime_type == "gmrt" {
	_expected = true;
}
grc_expect_eq(_expected, _loaded, "loading texgroup1 should succeed");
status = texturegroup_get_status("texgroup1");
grc_expect_true(status != texturegroup_status_unloaded, "texgroup1's status should not be unloaded anymore");
alarm[1] = 5;