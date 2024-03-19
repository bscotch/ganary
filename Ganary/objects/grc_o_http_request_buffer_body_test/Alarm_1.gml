/// @description Firing async_ids with interval

if (_test_index < array_length(_test_urls)){

	var the_test_method = _test_methods[_test_index];
	var test_endpoint = _test_endpoints[_test_index];
	var test_query_parameter = _test_query_parameters[_test_index];
	var body_handle = _body_handles[_test_index];
	var header_handle = _header_handles[_test_index];
	var test_url = _test_urls[_test_index];
		
	var http_request_handle = http_request(test_url, the_test_method, header_handle, body_handle);

	var test_record = {
	test_method: the_test_method,
	test_endpoint: test_endpoint,
	test_query_parameter: test_query_parameter,
	body_handle: body_handle,
	header_handle: header_handle
	}
	test_records[?http_request_handle] = test_record;
	test_completion_tracker [?http_request_handle] = 1; 	
	
	_test_index ++;
	alarm[1] = _test_interval;
}
