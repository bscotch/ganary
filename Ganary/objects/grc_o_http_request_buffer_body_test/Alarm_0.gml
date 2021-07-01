active = true;
var _grc_http_expected_headers = create_the_test_fixture_header();
var _grc_http_expected_body = create_the_test_fixture_body();

for (var j = 0; j < array_length(test_endpoints); j++){
	var test_endpoint = test_endpoints[j];
	#region Set query parameters and test methods for different endpoints
	var test_methods = ["POST"];
	var test_query_parameters = [""];
	switch (test_endpoint){
		case grc_http_test_endpoint_echo:
			test_query_parameters = ["?header=true"];
			break;
		case grc_http_test_endpoint_headers:
			test_methods = ["GET"];
			break;			
		case grc_http_test_endpoint_status:
			var http_statuses = [226, 451, 460, 462, 463];
			for ( var h = 200; h <= 204; h++){	array_push(http_statuses, h);	}
			for ( var h = 206; h <= 208; h++){	array_push(http_statuses, h);	}
			for ( var h = 300; h <= 308; h++){	array_push(http_statuses, h);	}
			for ( var h = 400; h <= 406; h++){	array_push(http_statuses, h);	}
			for ( var h = 408; h <= 431; h++){	array_push(http_statuses, h);	}
			for ( var h = 500; h <= 531; h++){	array_push(http_statuses, h);	}
			for (var h = 0; h < array_length(http_statuses); h++){
				http_statuses[h] = "/" + string(http_statuses[h]);
			}
			test_query_parameters = http_statuses;
			test_methods = ["GET"];
			break;
		case grc_http_test_endpoint_content_type:
			test_methods = ["GET"];
			test_query_parameters = ["/binary"];
			break;
	}
	#endregion
	for (var t = 0; t < array_length(test_query_parameters); t++){
		var test_query_parameter = test_query_parameters[t];
		var test_url = _grc_url_root + test_endpoint + test_query_parameter;

		for (var i = 0; i < array_length(test_methods); i++){
		  var the_test_method = test_methods[i];

		  #region Set the body according to the method
		  var body_handle;
		  var expected_body_handle;
		  if (the_test_method == "POST" || the_test_method == "PUT"){
		    body_handle = buffer_clone(_grc_http_expected_body);
		  }
		  else{
		    body_handle = buffer_create(1, buffer_grow, 1);
		  }
		  #endregion

		  #region Set the header's content-length
		  var header_handle = map_clone(_grc_http_expected_headers);
		    #region set Content-Length for POST and PUT
		    if (the_test_method == "POST" || the_test_method == "PUT"){
		      header_handle[?"Content-Length"] = buffer_get_size(body_handle);
		    }
		    #endregion
		  #endregion

		  #region Fire the request and get the http handle
		  var http_request_handle;
		  if (the_test_method == "POST" || the_test_method == "PUT"){
		    buffer_seek(body_handle, buffer_seek_start, 1);
		  }
		  else{
		    buffer_seek(body_handle, buffer_seek_start, 0);
		  }
		  http_request_handle = http_request(test_url, the_test_method, header_handle, body_handle);
		  #endregion

		  #region Register the test record
		  var test_record = {
			test_method: the_test_method,
			test_endpoint: test_endpoint,
			test_query_parameter: test_query_parameter,
		    body_handle: body_handle,
		    header_handle: header_handle
		  }
		  test_records[?http_request_handle] = test_record;
		  test_completion_tracker [?http_request_handle] = 1; 
		  #endregion
		}		
	}
}



ds_map_destroy(_grc_http_expected_headers);
buffer_delete(_grc_http_expected_body);