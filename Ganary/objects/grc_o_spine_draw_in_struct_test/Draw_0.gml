var _struct = {};
with _struct {
	var s0;
	if GM_runtime_type == "gmrt"{
		s0 = grc_player_fallfromspace_spine
	}
	else{
		s0 = handle_parse("ref sprite 0");
	}
	draw_sprite_ext(s0, 0, 0, 0, 1, 1, 0, c_white, 1);
}

if active {
	olympus_test_resolve();
	instance_destroy();
}