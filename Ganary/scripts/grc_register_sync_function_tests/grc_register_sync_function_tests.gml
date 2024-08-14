function grc_register_sync_function_tests(){
	olympus_add_test("static_scope_test", function(){
		new Bar();
	})
	
	olympus_add_test("show_debug_message_try_catch_test", function(){
		//https://github.com/YoYoGames/GameMaker-Bugs/issues/6190
		try {
		    show_error("test", false);
		}
		catch(exception) {
			show_debug_message(exception);
		}
	})
	
	olympus_add_test("ds_map_to_test", function(){
		var existing_arr = array_create(1, "value");
		show_debug_message("Should be able to access values with accessor, no accessor, and the function");
		for (var i = 0; i < array_length(existing_arr); i++){
				show_debug_message("no accessor:" + (existing_arr[i]));
				show_debug_message("accessor:" + (existing_arr[@i]));
				show_debug_message("function:" + (array_get(existing_arr, i)));
		}
		
		show_debug_message("Calling ds_map_*_to_array() on an empty map");
		var _map = ds_map_create();
		ds_map_keys_to_array(_map);
		ds_map_values_to_array(_map);
		
		for (var i = 0; i < array_length(existing_arr); i++){
			show_debug_message("no accessor:" + string(existing_arr[i]));
			show_debug_message("accessor:" + string(existing_arr[@i]));
			//Using the function throws an error
			show_debug_message("function:" + string(array_get(existing_arr, i)));
		}
		ds_map_destroy(_map);
	})
	
	olympus_add_test("real_number_to_int32", function(){
		var t = 8080;
		var t_type = typeof(t);
		grc_console_log("t_type:", t_type);
		grc_expect_eq(t_type, "number");

		var a = {
			// when assigning a number that will be the result of a ?? or ? operation
			b: undefined ?? 8080,
			c: is_undefined(undefined) ? 8080 : undefined
		}
		
		var b_type = typeof(a.b);
		grc_console_log("b_type:", b_type);
		grc_expect_eq(b_type, "number");
		
		var c_type = typeof(a.c);
		grc_console_log("c_type:", c_type);
		grc_expect_eq(c_type, "number");
	})

	olympus_add_test("ds_map_to_with_chain_accessor_test", function(){
		var existing_arr = array_create(1, "value");

		show_debug_message("Calling ds_map_*_to_array() on an empty map");
		var _map = ds_map_create();
		ds_map_keys_to_array(_map);
		ds_map_values_to_array(_map);
		
		
		var _map_hold_arrays = ds_map_create();
		_map_hold_arrays[? existing_arr[0]] = existing_arr;
		show_debug_message("Just bracket notaion:" + existing_arr[0]);
		show_debug_message("Using chain accessor with bracket notation in a ds_map: " + string(_map_hold_arrays[? existing_arr[0]]));
		ds_map_destroy(_map_hold_arrays);
		
		
		var array_of_structs = array_create(1, { "hello": "world" });
		show_debug_message("Just bracket notaion:" + string(array_of_structs[0]));
		show_debug_message("Using chain accessor with bracket notation to access the content of the struct: " +string(array_of_structs[0][$"hello"]));
	})	
	
	olympus_add_test("self_comparison_test", function(){
		var fist_comp = (self == other)
		var _self = self
		var second_comp = _self == other
		grc_expect_eq(fist_comp, second_comp);	
	})

	olympus_add_test("struct_addition_assignment", function(){
		#macro somekeyname "set"
		var s = {
			somekeyname: 1
		}
		
		s[$ somekeyname] += 2;
		grc_expect_eq(3, s[$ somekeyname]);
		
		s[$ somekeyname] = s[$ somekeyname] + 2;
		grc_expect_eq(5, s[$ somekeyname]);	
	})

	olympus_add_test("json_parse_nonstandard_json_value", function(){
		var _some_json = {
			"undefined": undefined,
			"infinity": infinity,
			"true": true,
			"false": false,
			"pi": pi,
			"text" : "@whatever"
		};
		var _some_json_string = json_stringify(_some_json);
		var _some_json_string_parsed = json_parse(_some_json_string);
		
		var names = struct_get_names(_some_json_string_parsed);
		for (var i = 0; i < array_length(names); i++){
			var name = names[i];
			var value = _some_json_string_parsed[$name];
			var expected_value = _some_json[$name];
			grc_expect_eq(value, expected_value, "Parsed value does not match the original value for name: " + name);
		}

		var _some_json = {
			"pointer_null": pointer_null,
			"pointer_invalid": pointer_invalid,
		};
		var _some_json_string = json_stringify(_some_json);
		var _some_json_string_parsed = json_parse(_some_json_string);

		var expected_parsed_value = {
			"pointer_null": undefined,
			"pointer_invalid": os_type == os_windows ? "FFFFFFFFFFFFFFFF" : "0xffffffffffffffff",
		}
		
		var names = struct_get_names(_some_json_string_parsed);
		for (var i = 0; i < array_length(names); i++){
			var name = names[i];
			var value = _some_json_string_parsed[$name];
			var expected_value = expected_parsed_value[$name];
			grc_expect_eq(value, expected_value, "Parsed value does not match the original value for name: " + name);
		}
		
		var _some_json = {
			"NaN": NaN,
		};
		var _some_json_string = json_stringify(_some_json);
		var _some_json_string_parsed = json_parse(_some_json_string);
		
		var name = "NaN";
		var value = _some_json_string_parsed[$name];
		var expected_value = expected_parsed_value[$name];
		grc_expect_neq(value, expected_value, "Parsed value does not match the original value for name: " + name);				
	})	

	olympus_add_test("ds_map_accessor_error", function(){
		function SomeStructWithMap() constructor
		{
			tags = ds_map_create();
			tags[? "hello" ] = { key : "value" };
		}
		
		globalvar SomeGlobalVar;
		SomeGlobalVar = new SomeStructWithMap();
		
		function SomeFuncAboutMaps( tags) 
		{
			var _tagged_frames = ds_map_find_value(SomeGlobalVar.tags, tags[0]);
			show_debug_message( $"_tagged_frames={_tagged_frames}" );
			var _tagged_frames = SomeGlobalVar.tags[? tags[0]];
			show_debug_message( $"_tagged_frames={_tagged_frames}" );
		} // end SomeFuncAboutMaps
		
		SomeFuncAboutMaps( [ "hello" ] );
	})	


	olympus_add_test("struct_accessor_after_json_parse", function(){
		var s = json_parse("{\"content-type\":\"world\"}");

		var actual = (s[$ "content-type"]);
		grc_expect_eq("world", actual);

		s[$ "content-type"] = "goodbye";

		var actual = (s[$ "content-type"]);
		grc_expect_eq("goodbye", actual);
	})		
	
	
	olympus_add_test("struct_chain_accessor_unset", function(){
		var s = {a: {hello: { lines : [  ], console : 1, verbose : 1, level : 2, enabled : 1 }}}
		var tag = "hello";
		s.a[$ tag].level = 1;
	})	

	olympus_add_test("struct_as_argument_with_chain_accessor",function(){
		// Create a nested struct.
		var _struct = { outer : { inner : 5 } };

		// ✅ Retrieve the value using chained accessors this way, without passing the _struct into a function. This works as expected.
		var _thing = _struct[$ "outer"].inner;

		function _get_chained_value(_nested_struct) {
			// ✅ This works, as expected.
			var _inner = _nested_struct.outer.inner;

			// ✅ The crash will not occur when retrieving the values one at a time, like this:
			var _outer = _nested_struct[$ "outer"];
			var _inner = _outer.inner;

			// ✅ The crash will not occur when chaining string accessors, like this:
			var _inner = _nested_struct[$ "outer"][$ "inner"];

			// ✅ The crash will not occur when chaining a string accessor after a dot accessor, like this:
			var _inner = _nested_struct.outer[$ "inner"];

			// 💥 Using a string accessor followed by a dot accessor causes this crash 💥
			// Variable <unknown_object>._nested_struct(116729, -2147483648) not set before reading it.
			var _inner = _nested_struct[$ "outer"].inner;
		}

		_get_chained_value(_struct);
	})

	olympus_add_test("calculation_that_start_with_minus", function(){
		function start_with_negative() {
			var foo = 0;
			var bar = 1;
			var bass = 2;
			var boat = 1;	
			foo	= -bar-(bass)*boat;
			return foo;
		}
		start_with_negative();
	}, {
		olympus_test_options_importance: olympus_test_importance.low
	})
	
	olympus_add_test("audio_exists", function(){
		var snd_index = 0;
		while true {
			if (audio_exists(snd_index)) {
				grc_console_log("Adding sound", snd_index, "to the lookup.");
				snd_index++;
			}
			else{
				break;
			}
		}
	})	

	olympus_add_test("struct_foreach", function(){
		show_debug_message("FOREACH?")
		struct_foreach({hello: "world"}, function(name){show_debug_message(name)});
		show_debug_message(":white_check_mark: FOREACH!")
	})

	olympus_add_test("shader_compile_test", function(){
		var shader_supported = shaders_are_supported();
		grc_expect_eq(true, shader_supported);
		var shader_compiled = shader_is_compiled(grc_shad_flash);
		grc_expect_eq(true, shader_compiled);	
	})

	olympus_add_test("extension_init", function(){
		var initialization_confirmation = undefined;
		switch os_type {
			case os_android:
				initialization_confirmation = _olympus_android_get_init_confirmation();
				break;
			case os_ios:
				initialization_confirmation = _olympus_ios_get_init_confirmation();
				break;
		}
		
		if (!is_undefined(initialization_confirmation)){
			grc_expect_eq("initialized", initialization_confirmation, "Extension did not initialize properly!")
		}		
	});

	olympus_add_test("clipboard_test", function(){
		if (os_type == os_ios || os_type == os_android || os_type == os_windows || os_type == os_macosx){
			var txt = "hello world";
			clipboard_set_text(txt);
			grc_expect_eq(clipboard_has_text(),  true);
			grc_expect_eq(clipboard_get_text(),  txt);
		}
		else{
			show_debug_message("The platform does not support clipboard function!");
		}		
	})

	olympus_add_test("json_parsed_struct_accessor_test", function(){
		var struc = {
			config: {
				os: {
					id: 0,
					status: 1
				}
			}
		}
		grc_expect_eq(struc.config.os.id, 0);
		grc_expect_eq(struc.config.os.status, 1);
		var parsed_struc = json_parse(json_stringify(struc));
		grc_expect_eq(parsed_struc.config.os.id, 0);
		grc_expect_eq(parsed_struc.config.os.status, 1);
	})
	
	olympus_add_test("alarm_set", function() {
		alarm[0] = 1;
	})
	
	olympus_add_test("viewport_set", function() {
		var cur_port =  view_wport[0];
		view_wport[0] = 100;
		view_wport[0] = cur_port;
	})
	
	olympus_add_test("struct_array_accessors_dot_notation", function() {
		var frame = {
			position	: [50, 50],
			half_size	: [25, 100],
			bounds		: [ [0, 0], [0, 0], [0, 0] ]
		}
	
		for ( var d = 0; d <= 1; d++) {
			frame.bounds[0][d]	= frame.position[d]-frame.half_size[d];
			frame.bounds[1][d]	= frame.bounds[0][d]+frame.half_size[d];
			frame.bounds[2][d]	= frame.bounds[1][d]+frame.half_size[d];
		}
	})
	
	olympus_add_test("struct_array_accessors_with", function() {
		var frame = {
			position	: [50, 50],
			half_size	: [25, 100],
			bounds		: [ [0, 0], [0, 0], [0, 0] ]
		}
		
		with frame {
			for ( var d = 0; d <= 1; d++) {
				bounds[0][d]	= position[d]-half_size[d];
				bounds[1][d]	= bounds[0][d]+half_size[d];
				bounds[2][d]	= bounds[1][d]+half_size[d];
			}
		}
	})
	
	olympus_add_test("struct_array_accessors_comparison", function() {
		var frame = { values : [100, 200] };
		
		grc_expect_true((frame.values[0] == 100), "Individual read check failed.");
		grc_expect_true((frame.values[1] == 200), "Individual read check failed.");
		
		grc_expect_true((frame.values[0] != frame.values[1]), "Equality check failed.");
		grc_expect_true((frame.values[1] != frame.values[0]), "Equality check failed.");
		
		grc_expect_true((frame.values[0] + frame.values[1]) == 300,	"Addition check failed.");
		grc_expect_true((frame.values[1] + frame.values[0]) == 300,	"Addition check failed.");
		grc_expect_true((frame.values[0] - frame.values[1]) == -100, "Subtraction check failed.");
		grc_expect_true((frame.values[1] - frame.values[0]) == 100,	"Subtraction check failed.");
		
		var struct_test_passthrough_function = function(arg0, arg1) {
			grc_expect_true(arg0 != arg1, "Passed through arguments should be different. Instead, they are", arg0, ",", arg1);
		}
		
		struct_test_passthrough_function(frame.values[0], frame.values[1]);
	})
	
	olympus_add_test("buffer_base64_decode_test", function(){
		grc_console_log("Testing buffer_base64_decode with short strings");
		var temp_buff = buffer_base64_decode("IHM=")
		buffer_delete(temp_buff);
		var temp_buff = buffer_create(1, buffer_grow, 1);
		buffer_base64_decode_ext(temp_buff, "IHM=", 0);
		buffer_delete(temp_buff);
		grc_console_log("buffer_base64_decode did not crash the runner");	
	})
	
	olympus_test_dependency_chain_begin();
	olympus_add_test("GM_runtime_version_test", function(){
		var runtime = GM_runtime_version;
		grc_expect_neq(runtime, "0.0.0.0");
		var version = string_split(runtime, ".");
		var major_version = real(version[0]);
		grc_expect_gt(2023, major_version);
	})

	olympus_add_test("json_parse_null_to_ptr_test", function(){
		var struc  = {crates: undefined};
		var str = json_stringify(struc);
		show_debug_message(str);
		var decode_struc = json_parse(str);
		var type = typeof(decode_struc.crates);
		var runtime = GM_runtime_version;
		var version = string_split(runtime, ".");
		var major_version = real(version[0]);
		var expected_type;	
		if major_version >= 2024{
			expected_type = "undefined";
		}
		else{
			expected_type = "ptr";
		}
		grc_expect_eq(expected_type, type, "For runtime "+GM_runtime_version+", the type should be "+expected_type + " but it is " +type);
	})
	olympus_test_dependency_chain_end();
	
	olympus_add_test("destroyed_ds_list_reference", function(){
		var destroyed_list = ds_list_create();
		ds_list_destroy(destroyed_list);
		var new_list = ds_list_create();
		grc_expect_true(ds_exists(destroyed_list, ds_type_list), "creating a new list should revive the old list");
		var expected_element = "hello"
		ds_list_add(new_list, expected_element);
		var element_from_destroyed_list = destroyed_list[|0];
		grc_expect_eq(expected_element, element_from_destroyed_list, "revived list should have the same element as the new list");
		grc_expect_eq(ds_list_size(new_list),  ds_list_size(destroyed_list), "revived list should have the same size as the new list");	
		ds_list_destroy(new_list);
	})
	
	olympus_add_test("cjk_text_function_test", function(){
		var english_text = "the brown fox jumped over the lazy dog. the brown fox jumped over the lazy dog. the brown fox jumped over the lazy dog."
		var chinese_text = "这些发光的巨型昆虫似乎只在夜间出没。它们的甲壳极度坚硬，而且它们非常易怒。"
		var japanese_text = "昨夜のコンサートは最高でした昨夜のコンサートは最高でした昨夜のコンサートは最高でした";
		var korean_text = "훈민정음훈민정음훈민정음훈민정음훈민정음훈민정음훈민정음훈민정음훈민정음훈민정음훈민정음훈민정음훈민정음";

		var text_list = ds_list_create();
		ds_list_add(text_list,
		english_text,
		chinese_text,
		japanese_text,
		korean_text
		)

		draw_set_font(grc_fnt_cjk);
		for (var i = 0; i < ds_list_size(text_list); i++){
			#region width
			var c_t_width = string_width(text_list[|i]);
			var c_t_width_interpolated = string_width(string_char_at(text_list[|i],1))*string_length(text_list[|i]);
			grc_expect_eq(c_t_width,c_t_width_interpolated,"Font width mismatch for text_list index: "+string(i));
			#endregion
	
			#region height
			var c_t_height = string_height(text_list[|i]);
			var c_t_height_individual = string_height(string_char_at(text_list[|i],1));	
			grc_expect_eq(c_t_height,c_t_height_individual,"Font height mismatch for text_list index: "+string(i));
			#endregion
	
			#region height and width with linebreak
			var width_no_break = string_width(text_list[|i]);
			var lines = 4;
			var width_per_line = width_no_break/lines;
			var processed_text = grc_cjk_insert_space(text_list[|i],width_per_line);
			var height_with_break = string_height_ext(processed_text,-1,width_per_line);
			var height_no_break = string_height(text_list[|i]);
			grc_expect_eq(height_with_break,height_no_break*(lines+1),"Font height after linebreak mismatch for text_list index: " + string(i));
			#endregion	
		}

		ds_list_destroy(text_list);	
	})
	
	olympus_add_test("ds_list_function_test", function(){
		var list = ds_list_create();

		ds_list_mark_as_map(list,0);

		var non_map_init = 0;
		while (ds_exists(non_map_init, ds_type_map)){
			non_map_init ++;
		}

		ds_list_add(list, non_map_init);
		ds_list_mark_as_map(list,0);
		ds_list_add(list, "a string");

		var map = ds_map_create();
		map[?"this"] = "that";

		ds_list_add(list, map);
		ds_list_mark_as_map(list,2);

		ds_list_destroy(list);

		grc_expect_eq(ds_exists(list, ds_type_list), false);
		grc_expect_eq(ds_exists(map, ds_type_map), false);	
	})
	
	olympus_add_test("file_name_with_number_test", function(){
		var fn = "Ganary/a773860.txt";
		grc_expect_eq(file_exists(fn), true);
		var fh = file_text_open_read(fn);
		var str = file_text_read_string(fh);
		file_text_close(fh);
		grc_expect_eq(str, "123");	
	})
	
	olympus_add_test("file_hash_function_test", function(){
		var fn = "Ganary/grc_file_hash_test_file";
		grc_expect_eq(md5_file(fn),md5_file(fn));
		grc_expect_eq(sha1_file(fn),sha1_file(fn));	
	})
	
	if (os_type != os_xboxone && os_type != os_uwp){
		olympus_add_test("directory_function_test", function(){
			var dir_name = "test_dir_name_for_directory_functions";
			directory_create(dir_name);
			grc_expect_eq(directory_exists(dir_name), 1);
		});
	}

	olympus_add_test("config_test", function(){
		var fn = "Ganary/grc_config_specific_file.md";
		var should_exists = os_get_config() == "steam" ? 1 : 0
		grc_expect_eq(should_exists, file_exists(fn));
		if should_exists{
			var fh = file_text_open_read(fn);
			var str = file_text_read_string(fh);
			file_text_close(fh);
			grc_expect_eq(str, "123");	
		}
	})
	
	olympus_add_test("struct_eval_test", function(){
		var s = {};
		if code_is_compiled(){
			if !s {
				throw("In YYC, struct should evaluate to true");
			}
		}
		else{
			if !s{
				throw("In VM, struct should evaluate to true");
			}
		}
	})

	olympus_add_test("fs_function_name_casing_test", function(){
		var fn = "Ganary/grc_lowercase.json";
		grc_expect_eq(file_exists(fn), true);
		var fh = file_text_open_read(fn);
		var str = file_text_read_string(fh);
		file_text_close(fh);
		grc_expect_eq(str, "123");

		var fn = "Ganary/Grc_Uppercase.json";
		grc_expect_eq(file_exists(fn), true);
		var fh = file_text_open_read(fn);
		var str = file_text_read_string(fh);
		file_text_close(fh);
		grc_expect_eq(str, "123");
	})

	olympus_add_test("null_type_checking", function(){
		grc_expect_eq(is_string(undefined), false);
		grc_expect_eq(is_real(undefined), false);
		grc_expect_eq(is_array(undefined), false);
		grc_expect_eq(is_int32(undefined), false);
		grc_expect_eq(is_int64(undefined), false);
		grc_expect_eq(is_bool(undefined), false);
		grc_expect_eq(is_undefined(undefined), true);
	})

	olympus_add_test("self_referencing_test", function(){
			var counter = 0;
			var counter_max = 5000;
			var self_reference_func = function(counter){
				counter ++;
				return counter;	
			}
			while counter < counter_max{
				counter = self_reference_func(counter);
			}
	})

	olympus_add_test("variable_function_test", function(){
		var test_instance = grc_instance_create(grc_o_helper_blank);
		test_instance.instance_variable_to_test = -1;
		grc_expect_eq(variable_instance_exists(test_instance, "instance_variable_to_test"), true);
		grc_expect_eq(variable_instance_get(test_instance, "instance_variable_to_test"), -1);
		variable_instance_set(test_instance, "instance_variable_to_test", "string");
		grc_expect_eq(variable_instance_exists(test_instance, "instance_variable_to_test"), true);
		grc_expect_eq(variable_instance_get(test_instance, "instance_variable_to_test"), "string");
		instance_destroy(test_instance);

		global.global_variable_to_test = -1;
		grc_expect_eq(real(variable_global_exists("global_variable_to_test")), true);
		grc_expect_eq(variable_global_get("global_variable_to_test"), -1);
		variable_global_set("global_variable_to_test", "string");
		grc_expect_eq(real(variable_global_exists("global_variable_to_test")), true);
		grc_expect_eq(variable_global_get("global_variable_to_test"), "string");
	})

	olympus_add_test("number_typing_test", function(){
		var fn = "number_type_test";
		var file = file_bin_open(fn, 2);
		var last_pos = file_bin_position(file);
		var data_wrote = irandom(255);
		file_bin_write_byte(file,data_wrote);
		var pos = file_bin_position(file);
		file_bin_seek(file, 0);
		var data_read = file_bin_read_byte(file);
		file_bin_close(file);

		grc_expect_eq(pos-last_pos, 1);

		if !code_is_compiled(){
			grc_expect_eq(is_real(data_read), true);
			grc_expect_eq(is_real(data_wrote), true);
			grc_expect_eq(is_int64(data_read), false);
			grc_expect_eq(is_int64(data_wrote), false);	
		}
		else{
			grc_expect_eq(is_real(data_read), true);
			grc_expect_eq(is_real(data_wrote), true);
			grc_expect_eq(is_int64(data_read), false);
			grc_expect_eq(is_int64(data_wrote), false);	
		}
	})

	olympus_add_test("buffer_compression_test", function(){
		var raw_fn = "Ganary/grc_testbuff.raw";
		var compressed_fn = "Ganary/grc_testbuff.compressed"

		var src_inflated = buffer_load(raw_fn);
		var src_deflated = buffer_load(compressed_fn);
		var test_inflated = buffer_decompress(src_deflated);
		var test_deflated = buffer_compress(src_inflated, 0, buffer_get_size(src_inflated));

		grc_expect_eq(buffer_get_size(src_inflated), buffer_get_size(test_inflated));
		buffer_seek(src_inflated, buffer_seek_start, 0);
		buffer_seek(test_inflated, buffer_seek_start, 0);
		for(var i=0; i<buffer_get_size(src_inflated);i++){
		  var src_byte = buffer_read(src_inflated, buffer_s8);
		  var test_byte = buffer_read(test_inflated, buffer_s8);
		  grc_expect_eq(src_byte, test_byte);
		}

		grc_expect_eq(buffer_get_size(src_deflated), buffer_get_size(test_deflated))
		buffer_seek(src_deflated, buffer_seek_start, 0);
		buffer_seek(test_deflated, buffer_seek_start, 0);
		for(var i=0; i<buffer_get_size(src_deflated);i++){
		  var src_byte = buffer_read(src_deflated, buffer_s8);
		  var test_byte = buffer_read(test_deflated, buffer_s8);
		  grc_expect_eq(src_byte, test_byte);
		}

		buffer_delete(src_inflated);
		buffer_delete(src_deflated);
		buffer_delete(test_inflated);
		buffer_delete(test_deflated);
	})

	olympus_add_test("fs_function_test", function(){
		//Testing pathname longer than 64 char
		var non_ascii_top = "萨达/";
		fn = "c/GeneralDev/gms_runtime_checker/includedFile/VeryVeryLong/5d317eafe0122500717e052c.txt"
		if os_type != os_xboxone && os_type != os_uwp && os_type != os_xboxseriesxs{
			fn = non_ascii_top + fn	
		}
		var file_name_name = filename_name(fn);
		grc_expect_eq(file_name_name, "5d317eafe0122500717e052c.txt");
		var fh = file_text_open_write(fn);
		var str = file_text_write_string(fh, fn);
		file_text_close(fh);
		if (os_type == os_xboxone || os_type == os_xboxseriesxs) && xboxone_get_file_error() != xboxone_fileerror_noerror
		{
			show_debug_message("Save failed. Error code = " + string(xboxone_get_file_error()));
		}
		var fh = file_text_open_read(fn);
		var str = file_text_read_string(fh);
		file_text_close(fh);
		grc_expect_eq(str,fn);
		var fn = "file_bin_test";
		var file = file_bin_open(fn, 2);
		var pos = file_bin_position(file);
		grc_expect_eq(pos,0);
		var data = irandom(255);
		file_bin_write_byte(file,data);
		pos = file_bin_position(file);
		grc_expect_eq(pos,1);
		file_bin_seek(file, 0);
		var data_read = file_bin_read_byte(file);
		grc_expect_eq(data, data_read);
		var size = file_bin_size(file);
		grc_expect_eq(size,1);
		file_bin_close(file);
		var s5 = "sssss";
		var v6 = "vvvvvv";
		var fn = "shared_fn"
		//Write old data that is long
		var fh = file_text_open_write(fn);
		file_text_write_string(fh, v6);
		file_text_close(fh);
		switch_save_data_commit();
		//Write new data that is shorter than old data
		var fh = file_text_open_write(fn);
		file_text_write_string(fh, s5);
		file_text_close(fh);
		switch_save_data_commit();
		var fh = file_text_open_read(fn);
		var content = file_text_read_string(fh);
		file_text_close(fh);
		grc_expect_eq(content, s5);
	})

	olympus_add_test("json_encode_test", function(){
		var map_to_test;
		map_to_test = ds_map_create();
		for ( var i = 0; i < 10; i++){
			var submap		= ds_map_create();
			ds_map_add(submap, i, 0);
			ds_map_add_map(map_to_test, i, submap);
		}

		var encoded_string = json_encode(map_to_test);
		ds_map_destroy(map_to_test);
		var map_to_test = json_decode(encoded_string);
		grc_expect_neq(map_to_test, -1);

		for ( var i = 0; i < 10; i++){
			var index = string(i);
			grc_expect_eq(ds_map_exists(map_to_test,index), true);
			var submap = map_to_test[?index];
			grc_expect_eq(ds_map_exists(submap, index), true);
			grc_expect_eq(submap[?index], 0);
		}

		ds_map_destroy(map_to_test);

		//For testing mutations caused by json_encode
		var test_map = ds_map_create();
		ds_map_add_map(test_map, "a_map", ds_map_create());
		ds_map_add_list(test_map, "a_list", ds_list_create());

		var encoded_string = json_encode(test_map);
		var double_encoded_string = json_encode(test_map);

		grc_expect_eq(encoded_string, double_encoded_string);
		ds_map_destroy(test_map);
	})
	
	olympus_add_test("add_sprite_function_test", function(){
		grc_console_log("Testing whether adding images would crash");
		var jpg_fn = "Ganary/grc_test_jpg_crash.jpg"  
		var gif_fn = "Ganary/grc_test_gif_crash.gif"
		var png_fn = "Ganary/grc_test_png_crash.png"

		var jpg = sprite_add(jpg_fn, 1, true, true, 0, 0);
		grc_expect_eq(sprite_exists(jpg), true);
		sprite_delete(jpg);
		grc_expect_eq(sprite_exists(jpg), false);

		var gif = sprite_add(gif_fn, 1, true, true, 0, 0);
		grc_expect_eq(sprite_exists(gif), true);
		sprite_delete(gif);
		grc_expect_eq(sprite_exists(gif), false);

		var png = sprite_add(png_fn, 1, true, true, 0, 0);
		grc_expect_eq(sprite_exists(png), true);
		sprite_delete(png);
		grc_expect_eq(sprite_exists(png), false);
	})
	
	olympus_add_test("buffer_base64_encode_test", function(){
		var fn = "Ganary/grc_buffer_encode_test_file"
		var old_buff = buffer_load(fn);
		var buff = buffer_decompress(old_buff);
		buffer_delete(old_buff);
		buffer_seek(buff, buffer_seek_start, 196481);
		buffer_base64_encode(buff, 0, buffer_tell(buff));
		buffer_delete(buff);
		show_debug_message("Testing if the string is too short, base64 decode will not crash.");
		var _string = "AA="
		var ext_buff = buffer_create(1, buffer_grow, 1);
		buffer_base64_decode_ext(ext_buff, _string, 0);
		show_debug_message("Does not crash when the string is too short!");
		buffer_delete(ext_buff);
		var _buff = buffer_base64_decode(_string);
		show_debug_message("Does not crash when the string is too short!");
		buffer_delete(_buff);	
	})
	
	
	
	if os_get_config() == "dev"{
		olympus_add_test("show_debug_message_test", function(){
			var very_long_string = "";
			for (var i = 0; i < 775; i += 1)
				{
						very_long_string += grc_utf8_chars;
				}
			show_debug_message(very_long_string)
		})
	}
}