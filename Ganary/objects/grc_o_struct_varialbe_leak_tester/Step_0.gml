var _time = get_timer();
	
for (var i = 0; i < num_entries; i++){ 
	var _key = _generate_consonumeric_string(12);
	struct[$ _key] = true;
}
	
var _time_to_add_keys = get_timer()-_time;

	
show_debug_message($"Iteration {iterations}: {round(_time_to_add_keys/1000)} Milliseconds");

struct_foreach(struct,
	method(struct,
		function(_key) {
			struct_remove(self, _key)
		}
	)
)

if iterations == 0 {
	time_to_add_keys_initial = _time_to_add_keys;
}
else if iterations == 10 {
	time_to_add_keys_final = _time_to_add_keys;
	var diff = time_to_add_keys_final/time_to_add_keys_initial
	show_debug_message($"Iteration over {iterations}: {diff}");
	var diff_is_acceptable = diff < 2;
	if !diff_is_acceptable {
		grc_async_assert(2, diff, "Diff should not be more than 2 times");
	}
	else{
		olympus_test_resolve();
		instance_destroy();
	}
}

iterations += 1;
gc_collect();