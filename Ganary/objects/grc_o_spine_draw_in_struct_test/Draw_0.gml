var _struct = {};
with _struct {
	var s0 = handle_parse("ref sprite 0");
	var s1 = handle_parse("ref sprite 1");
	draw_sprite_ext(s1, 0, 0, 0, 1, 1, 0, c_white, 1);
	draw_sprite_ext(s0, 0, 0, 0, 1, 1, 0, c_white, 1);
}

if active {
	olympus_test_resolve();
}