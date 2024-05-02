event_inherited()
seeked = false;
seeked_position = 500;
if os_type == os_windows {
  show_debug_message("On Windows. Will complete the test in 2 seconds.");
  call_later(2, time_source_units_seconds, function(){
    olympus_test_resolve();
    instance_destroy();    
  });
}
