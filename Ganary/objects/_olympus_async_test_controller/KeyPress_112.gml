/// @description Insert description here
// You can write your code in this editor
if debug_mode{
	var current_test = global._olympus_suite_manager.current_suite.get_current_test();
	current_test.reject({message:"manually stopped the test."}, olympus_error_code.skip_with_bail);
}

























