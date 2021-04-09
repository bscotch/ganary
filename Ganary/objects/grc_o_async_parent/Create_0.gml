active = false;

///@description Expects that the actual value is equal to the expected value. If failed, reject the test
///@param {*} expected
///@param {*} actual
///@param {String} [additional_message]
grc_async_assert = function(expected, actual){
	var additional_message = argument_count > 2 ? argument[2] : "";
	try{
		grc_throw_result(expected, actual, expected == actual, additional_message);
	}
	catch(err){
		olympus_test_reject(err);
		instance_destroy();
	}
}

alarm[0] = 1;