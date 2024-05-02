var _struct = {};
with _struct {
	var s0 = handle_parse("ref sprite 0");
	draw_sprite_ext(s0, 0, 0, 0, 1, 1, 0, c_white, 1);
}

if active {
	olympus_test_resolve();
	instance_destroy();
}