var ins_exists = instance_exists(storedInstance);
grc_console_log("Room restarted: " + string(restarted));
grc_console_log("Still exists: " + string(ins_exists));
with storedInstance.id
{
	var _thing = self;
	var eq = (_thing == other.storedInstance);
	other.grc_async_assert(ins_exists, eq);
}

if restarted {
	instance_destroy();
}