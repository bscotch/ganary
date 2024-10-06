global.truthiness_test_passed = true;
function _test_truthiness(name, value, truthy, expect_equals, expect_not_equals) {		
	expect_equals		= _to_array(expect_equals);
	expect_not_equals	= _to_array(expect_not_equals);
	grc_console_log("Testing truthiness of", name);
	
	if is_undefined(truthy) {
		var properly_crashed = false;
		try {
			if value {
				// Should crash.
			}
		}
		catch(msg) {	
			msg = "This is to get rid of the syntax error."
			properly_crashed = true;
		}
		_compare_and_record(properly_crashed, "Expected to be unable to use " + string(name) + " in 'if' statement, but we were able to use it.");
	}
	else {
		if value {	_compare_and_record(truthy,	"Expected to be truthy, but was falsy: "+ string(name)); }
		else {		_compare_and_record(!truthy,	"Expected to be falsey, but was truthy: " + string(name)); }
	}
				
	for ( var j = 0; j <  array_length(expect_equals); j++){
		var _comparison_value = expect_equals[j];
		_compare_and_record(value == _comparison_value, "Expected " + string(name) + " to be equal to " + string(_comparison_value) + ", but it wasn't.");
	}
				
	for ( var j = 0; j <  array_length(expect_not_equals); j++){
		var _comparison_value = expect_not_equals[j];
		_compare_and_record(value != _comparison_value, "Expected " + string(name) + " to NOT be equal to " + string(_comparison_value) + ", but it was.");
	}
}

function _to_array(value){
	return is_array(value) ? value : [value];
}

function _compare_and_record (result, _message){
	if (!result){
		global.truthiness_test_passed = false;
		grc_console_log(_message);
	}
}