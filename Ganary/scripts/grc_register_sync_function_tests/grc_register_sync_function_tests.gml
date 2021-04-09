function grc_register_sync_function_tests(){
	
	olympus_add_test("buffer_base64_decode_test", function(){
		grc_console_log("Testing buffer_base64_decode with short strings");
		var temp_buff = buffer_base64_decode("IHM=")
		buffer_delete(temp_buff);
		var temp_buff = buffer_create(1, buffer_grow, 1);
		buffer_base64_decode_ext(temp_buff, "IHM=", 0);
		buffer_delete(temp_buff);
		grc_console_log("buffer_base64_decode did not crash the runner");	
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
	
	if os_get_config() == "steam"{
		grc_expect_eq(steam_initialised(),true);
	}
	
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
	
	olympus_add_test("directory_function_test", function(){
		var dir_name = "test_dir_name_for_directory_functions";
		directory_create(dir_name);
		grc_expect_eq(directory_exists(dir_name), 1);
	});

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
		grc_expect_eq(variable_instance_exists(test_instance, "instance_variable_to_test"), false);
		test_instance.instance_variable_to_test = -1;
		grc_expect_eq(variable_instance_exists(test_instance, "instance_variable_to_test"), true);
		grc_expect_eq(variable_instance_get(test_instance, "instance_variable_to_test"), -1);
		variable_instance_set(test_instance, "instance_variable_to_test", "string");
		grc_expect_eq(variable_instance_exists(test_instance, "instance_variable_to_test"), true);
		grc_expect_eq(variable_instance_get(test_instance, "instance_variable_to_test"), "string");
		instance_destroy(test_instance);

		grc_expect_eq(real(variable_global_exists("global_variable_to_test")), false);
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
		if os_type != os_xboxone{
			fn = non_ascii_top + fn	
		}
		var file_name_name = filename_name(fn);
		grc_expect_eq(file_name_name, "5d317eafe0122500717e052c.txt");
		var fh = file_text_open_write(fn);
		var str = file_text_write_string(fh, fn);
		file_text_close(fh);
		if os_type == os_xboxone && xboxone_get_file_error() != xboxone_fileerror_noerror
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
	
	olympus_add_test("encoding_functions_test", function(){
		grc_console_log("Testing base64_decode and encode with short strings");
		var test_string = "h"
		grc_expect_eq(base64_decode(base64_encode(test_string)),test_string);

		var s_lenght = max(grc_encode_string_length,grc_encode_string_length_max)
		grc_console_log("Testing base64_decode and encode with long strings", s_lenght)
		var test_string = "";
		repeat s_lenght {
			test_string += string(irandom(9));
		}
		grc_expect_eq(base64_decode(base64_encode(test_string)),test_string);

		var test_map = ds_map_create();
		test_map[?"test_string"] = test_string;
		var test_json_string = json_encode(test_map);
		ds_map_destroy(test_map);
		var converted_map = json_decode(test_json_string);
		grc_expect_eq(converted_map[?"test_string"], test_string);
		ds_map_destroy(converted_map);

		grc_expect_eq(md5_string_utf8(test_string),md5_string_utf8(test_string));
		grc_expect_eq(md5_string_unicode(test_string),md5_string_unicode(test_string));

		grc_expect_eq(sha1_string_utf8(test_string),sha1_string_utf8(test_string));
		grc_expect_eq(sha1_string_unicode(test_string),sha1_string_unicode(test_string));

		var very_long_string = "";

		// Create a long string
		// Setting the value below to 25800 (which is 774,000 string length) DOES NOT cause a stack-overflow
		// Setting the value below to 25834 (which is 775,020 string length) DOES cause a stack-overflow

		for (var i = 0; i < 25834; i += 1)
			{
					very_long_string += grc_utf8_chars;
			}
	
		show_debug_message("Created string of length: " + string(string_length(very_long_string)));
		show_debug_message("Start md5 utf8");
		md5_string_utf8(very_long_string);
		show_debug_message("md5 utf8 successful");
	}, {
		olympus_test_options_timeout_millis: 60000*5
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