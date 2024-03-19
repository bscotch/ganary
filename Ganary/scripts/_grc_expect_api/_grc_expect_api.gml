///@description Expects that the actual value is equal to the expected value
///@param {*} expected
///@param {*} actual
///@param {String} [additional_message]
function grc_expect_eq(expected, actual) {
	var additional_message = argument_count > 2 ? argument[2] : "";
	grc_throw_result(expected, actual, expected == actual, additional_message);
}

///@description Expects that the provided value is false
///@param {*} value
///@param {String} [additional_message]
function grc_expect_false(value) {
	var additional_message = argument_count > 1 ? argument[1] : "";
	grc_expect_eq(false, value, additional_message);
}

///@description Expects that the provided value is true
///@param {*} value
///@param {String} [additional_message]
function grc_expect_true(value) {
	var additional_message = argument_count > 1 ? argument[1] : "";
	grc_expect_eq(true, value, additional_message);
}

///@description Expects that the actual value is greater than the expected value
///@param {*} expected
///@param {*} actual
///@param {String} [additional_message]
function grc_expect_gt(expected, actual) {
	var additional_message = argument_count > 2 ? argument[2] : "";
	grc_throw_result(expected, actual, expected < actual, additional_message);
}

///@description Expects that the actual value is less than the expected value
///@param {*} expected
///@param {*} actual
///@param {String} [additional_message]
function grc_expect_lt(expected, actual) {
	var additional_message = argument_count > 2 ? argument[2] : "";
	grc_throw_result(expected, actual, expected > actual, additional_message);
}

///@description Expects that the actual value is not equal to the expected value
///@param {*} expected
///@param {*} actual
///@param {String} [additional_message]
function grc_expect_neq(expected, actual) {
	var additional_message = argument_count > 2 ? argument[2] : "";
	grc_throw_result(expected, actual, expected != actual, additional_message);
}

///@description Expects that the provided value is not null
///@param {*} value
///@param {String} [additional_message]
function grc_expect_not_null(value) {
	var additional_message = argument_count > 1 ? argument[1] : "";
	grc_throw_result("not null", value, !_grc_is_null(value), additional_message);
}

///@description Expects that the provided value is null
///@param {*} value
///@param {String} [additional_message]
function grc_expect_null(value) {
	var additional_message = argument_count > 1 ? argument[1] : "";
	grc_throw_result("null", value, _grc_is_null(value), additional_message);
}

///@description Expects that the provided function to throw an error
///@param {function} a function to execute a block of code
///@param {String} [additional_message]
function grc_expect_error(func) {
	var additional_message = argument_count > 1 ? argument[1] : "";
	var err;
	try(func())
	catch(crash_err){
		show_debug_message(json_stringify(crash_err))
		err = crash_err;
	}	
	grc_throw_result("Error", "No error",  is_undefined(err), additional_message);
}

///@description Throws an exception if the provided values do not match
///@param {*} expected
///@param {*} actual
///@param {Bool} matches
///@param {String} [additional_message]
function grc_throw_result(expected, actual, matches) {
	var additional_message = argument_count > 3 ? argument[3] : "";
	if additional_message != ""{
		additional_message += ": ";
	}
	if (!matches){
		var errorMessage = additional_message + "Expected [" + string(expected) + "] Actual [" + string(actual) + "]";
		show_error(errorMessage, true);
	}
}

#region Typechecking

///@desc Checks if the provided value is an int or not
///@param {*} value The value to check
///@returns {Bool} True if int, false otherwise
function _grc_is_int(value) {
	if (is_undefined(value) || !is_numeric(value)){
		return false;
	}

	var remainder = value % 1;
	return remainder == 0;
}

///@desc Checks if the provided value is null or not
///@param {*} value The value to check
///@returns {Bool} True if null, false otherwise
function _grc_is_null(value){
	var result = is_undefined(value) || !_grc_is_int(value) || value == noone || value < 0 || !instance_exists(value);
	return result;
}

#endregion