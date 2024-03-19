if (active) {
  if (ds_map_empty(test_completion_tracker)){    
	if (array_length_safe(errors) > 0){
		olympus_test_reject(errors);
	}
	else{
		olympus_test_resolve();
	}
	instance_destroy();
  }
}