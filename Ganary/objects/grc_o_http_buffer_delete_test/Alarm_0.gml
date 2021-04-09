// Inherit the parent event
event_inherited();
try{
	buffer_delete(receiving_buffer);
}
catch(err){
	grc_async_assert(err.message, "Cannot delete buffer, it's in use by 1 others");
}