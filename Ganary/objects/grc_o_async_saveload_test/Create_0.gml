event_inherited()
timeout = 0;
timeout_max = 3;

value = 0;
expected_value = value;
saveid = -1;
loadid = -1;

saving = false;
loading = false;

enum asycn_saveload_next_action{
	load,
	save,
	evaluate
}

next_action = asycn_saveload_next_action.save;

var non_ascii_top = "萨达/c/GeneralDev/gms_runtime_checker/";
save_fn = "12345678/includedFile/VeryVeryLong/5d317eafe0122500717e052c.txt" //Xbox has a 63 char length max for async fn
if os_type != os_xboxone{
	save_fn = non_ascii_top + save_fn;	
}

//save_fn = "this"