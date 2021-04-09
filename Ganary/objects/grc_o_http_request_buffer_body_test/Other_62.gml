var _id = async_load[?"id"];
if (ds_map_exists(test_records, _id)){
  if (async_load[?"status"] == 0 || async_load[?"status"] < 0) {
    var test_record = test_records[?_id];
    ds_map_delete(test_completion_tracker, _id);
	
	var expected;
	var actual;
	var passed = true;
	switch (test_record.test_endpoint){
		case grc_http_test_endpoint_echo:
			var test_body_size = buffer_get_size(test_record.body_handle);
			var test_body_encoded = buffer_base64_encode(test_record.body_handle, 0 , test_body_size);
			expected = test_body_encoded;
			actual = async_load[?"response_headers"][?"x-rumpus-dummy-body"];
			passed = (expected == actual);
			break;
		case grc_http_test_endpoint_content_type:
			var test_body = test_record.body_handle;
			buffer_seek(test_body, buffer_seek_start, 0);
			actual = buffer_read(test_body, buffer_string);
			expected = "Hello World";
			passed = (actual == expected);
			break;
		case grc_http_test_endpoint_headers:
			var test_body = test_record.body_handle;
			buffer_seek(test_body, buffer_seek_start, 0);
			var actual_headers_string = buffer_read(test_body, buffer_string);
			var actual_response_map = json_decode(actual_headers_string);
			var actual_headers = actual_response_map[?"data"];
			var expected_headers = test_record.header_handle;
			var keys = ds_map_keys_to_array(expected_headers);
			for (var i = 0; i < array_length(keys); i++){
				var key = keys[i];
				var key_lower = string_lower(key);
				if (expected_headers[?key] != actual_headers[?key_lower]){
					passed = false;
					break;
				}
			}
			actual = json_encode(actual_headers);
			expected = json_encode(expected_headers);
			ds_map_destroy(actual_headers);
			break;
		case grc_http_test_endpoint_status:
			actual = string(async_load[?"http_status"]);
			var expected_status = string_replace_all(test_record.test_query_parameter, "/", "");
			switch (expected_status){
				case "301":
				case "302":
				case "303":
				case "307":
				case "308":
					expected = "200";
					break;
				default:
					expected = expected_status;
					//Also check the body for 204
					if (actual == expected && expected_status == "204"){
						var test_body = test_record.body_handle;
						buffer_seek(test_body, buffer_seek_start, 0);
						actual = buffer_read(test_body, buffer_string);
						expected = "";	
					}					
					break;
			}			
			passed = (actual == expected);
			break;		
	}
		
	if (!passed){
		var err = {
			name: test_record.test_endpoint + "_" + test_record.test_method,
			expected : expected,
			actual: actual
		}
		array_push(errors, err);
	}
	
	buffer_delete(test_record.body_handle);
	ds_map_destroy(test_record.header_handle);
  }
}