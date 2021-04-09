event_inherited();
/*
Summary:

If you have created a number of arrays past some threshold, then do the following:
	- Pass an array into Function A
	- Have Function A pass the array into struct Function B
	- Have struct Function B assign the array to a struct variable
	- Use the YoYoCompiler on Windows to run the project
Then the array in the struct will be garbage collected, when it should be kept.

Additional notes:
	The result is the same whether the struct function is static or not.
	
	The number of arrays required to trigger this problem seems to change based on
	what data structures have been created beforehand, but will be 100% replicable
	for the same exact scenario.
	
	For example, if you add a single script to this project heirarchy, then the number of
	arrays required to be created before the error occurs will decreased by 2.
	
	We first spotted this in our main game project, Crashlands 2. In that project,
	we are seeing this issue on all platforms, plus silent crashes that seem to be
	linked to it.
	
	I went back and sampled some older Runtimes to see if this is a new problem.
		It occurs in:
			- 23.1.1.248 (current)
			- 23.1.1.235
			- 23.1.1.212
			- 23.1.1.187
		I didn't check farther back than that.
*/

frame_max = 200;
frame = 0;
frame_number_to_assign_new_array = 5; // If we reassign the array before frame 5, the error will not occur.

ArrayHolder = function() constructor {
	held_array = [];
	
	/// @arg array
	static set_array_in_struct = function() {
		held_array = argument_count > 0 ? argument[0] : [];
		
		show_debug_message("Struct has assigned held_array to new value: " + string(held_array));
		show_debug_message("    New struct contents: " + json_stringify(self));
	}
}

struct = new ArrayHolder();

// Here, we'll make a bunch of arrays and hold them in another array to keep their reference.

var num_arrays_that_cause_dereference			= 180;

array_stockpile = [];
for ( var i = 0; i < num_arrays_that_cause_dereference; i++){
	//var some_array = [1,2,3];
	array_stockpile[i] = [1,2,3];
}

pass_array_to_struct_assignment_function = function() {
	var array = argument[0];//argument_count > 0 ? argument[0] : [];
	struct.set_array_in_struct(array); // Passing the array into the struct function will cause a downstream assignment error.
	// struct.held_array = ["This works!"] // If you assign it this way, the variable is properly set. No error.
}

pass_array_to_struct_assignment_function(["Assigned on create"]);