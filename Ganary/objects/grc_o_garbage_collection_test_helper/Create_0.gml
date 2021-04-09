/// @description Insert description here
// You can write your code in this editor
var test_method = function(){
	with grc_o_garbage_collection_test{
		switch working {
			case true:
				with grc_o_garbage_collection_test_helper {
						show_debug_message("debuggg");
						exit;
					}
				break;
			default:
				break;
		}
	}
}

test_method();
with grc_o_garbage_collection_test{
	show_debug_message("Finished running the method");
}
instance_destroy();