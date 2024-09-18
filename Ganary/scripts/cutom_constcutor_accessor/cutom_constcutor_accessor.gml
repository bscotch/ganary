function TestClass() constructor {
	__test_class = new TestClassWithStruct();
	
	static get_1 = function() {
		return __test_class;
	}
	
	static get_2 = function() {
		return __test_class;
	}
}


function TestClassWithStruct() constructor {
	//__struct = {};
	//__arr = [];
	__var = "Foo";
	
	// You can try to read any type of variable - structs, arrays, strings etc. 
	// Just try to change __var to __struct in try_to_read variable below.

	static func = function() {
		var try_to_read = __var; // <- SILENT CRASH HERE
		show_debug_message("func: " + string(try_to_read));
		
		return 0;
	}
}


function some_function(_test_class1, _test_class2) {
	show_debug_message(_test_class1);
	show_debug_message(_test_class2);
}