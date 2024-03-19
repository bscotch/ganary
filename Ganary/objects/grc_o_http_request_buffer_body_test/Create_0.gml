///@desc Constructor pattern
active = false;
alarm[0] = 1;
#region Member functions
create_the_test_fixture_header = function(){
	var _grc_http_expected_headers_map = ds_map_create();
	_grc_http_expected_headers_map[?"Content-Type"] = "application/octet-stream";
	//_grc_http_expected_headers_map[?"Cookie"] = "dummy_cookie";
	_grc_http_expected_headers_map[?"Locale"] = "en-US";
	_grc_http_expected_headers_map[?"accept"] = "application/json";
	//_grc_http_expected_headers_map[?"Content-Encoding"] = "deflate";
	_grc_http_expected_headers_map[?"User-Agent"] = "Olympus/1.0.0";
	return _grc_http_expected_headers_map;
}

create_the_test_fixture_body = function(){
  var buffer_trim_and_compress = function (buffer_handle) {
    var actual_size = buffer_tell(buffer_handle);
    var fixed_buffer_handle = buffer_create(actual_size, buffer_fixed, 1);
    buffer_seek(buffer_handle, buffer_seek_start, 0);		
    buffer_copy(buffer_handle, 0, actual_size, fixed_buffer_handle, 0);
    buffer_delete(buffer_handle);
    
    buffer_seek(fixed_buffer_handle,buffer_seek_start,0);
    var compressed_buffer = buffer_compress(fixed_buffer_handle, 0, actual_size);
    buffer_delete(fixed_buffer_handle);
    
    return compressed_buffer;
  }

  var _grc_http_body_strings = "!#$%&'()*+,-./0123عض لفرنسا استطاعوا 戒文高提規金開。鯨明約着熊吉判псум долор сит амет, ад при и";
  var _grc_http_body_u8 = 255;
  var _grc_http_body_u16 = 65535;
  var _grc_http_body_u32 = 4294967295;
  var body = buffer_create(1, buffer_grow, 1);
  buffer_write(body, buffer_string, _grc_http_body_strings);
  buffer_write(body, buffer_u8, _grc_http_body_u8);
  buffer_write(body, buffer_u16, _grc_http_body_u16);
  buffer_write(body, buffer_u32, _grc_http_body_u32);
  buffer_write(body, buffer_string, _grc_http_body_strings);
  return buffer_trim_and_compress(body);
}

buffer_clone = function (src){
  var expected_size = buffer_get_size(src);
  var new_buffer = buffer_create(expected_size, buffer_fixed, 1);
  buffer_seek(new_buffer, buffer_seek_start, 0);
  buffer_seek(src, buffer_seek_start, 0);
  buffer_copy(src, 0, expected_size, new_buffer, 0);
  return new_buffer;
}

map_clone = function(src){
  var new_map = ds_map_create();
  ds_map_copy(new_map, src);
  return new_map;
}

#endregion

#region Member variables
test_endpoints = [
	grc_http_test_endpoint_echo,
	grc_http_test_endpoint_status,
	grc_http_test_endpoint_headers,
	grc_http_test_endpoint_content_type
];
test_records = ds_map_create();
test_completion_tracker = ds_map_create();
#macro _grc_url_root "https://beta.bscotch.net/api/dummy/"
errors = [];
#endregion

#macro grc_http_test_endpoint_echo "echo"
#macro grc_http_test_endpoint_status "status"
#macro grc_http_test_endpoint_headers "headers"
#macro grc_http_test_endpoint_content_type "content-type"

_test_urls = array_create(0);
_test_methods = array_create(0);
_header_handles = array_create(0);
_body_handles = array_create(0);
_test_query_parameters = array_create(0);
_test_endpoints = array_create(0);
_test_interval = (os_type == os_xboxone || os_type == os_xboxseriesxs) ? 3 : 1;
_test_index = 0;