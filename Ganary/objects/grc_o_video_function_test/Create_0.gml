event_inherited()
seeked = false;
seeked_position = 500;

if (os_type == os_windows) {
  var device_info = os_get_info();
  var device_name = device_info[? "video_adapter_description"];
  if (device_name == "Microsoft Basic Render Driver"){
    show_debug_message("Running in GitHub Actions. Will complete the test in 2 seconds.");
    call_later(2, time_source_units_seconds, function(){
      olympus_test_resolve();
      instance_destroy();    
    });
  }
}