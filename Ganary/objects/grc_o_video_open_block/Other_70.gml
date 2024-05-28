/// @description Insert description here
// You can write your code in this editor
if async_load[? "type"] == "video_start"{
	if (!started_already){
		started_already = true;
		video_open("Ganary/cutscenes/grc.mp4");
	}
	else{
		olympus_test_reject("Should not be able to open another video without first closing!");
	}
}