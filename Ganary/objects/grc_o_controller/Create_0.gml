/// @description Insert description here
// You can write your code in this editor

mPadId = 0; // should be set from objControllerSupport

enum eState
{	Init
,	Running
,	Cleanup
};

mState = eState.Init;
mHasInit = false;
mType = switch_controller_handheld;
mJoyCons = [ false, false ];
mColour = c_white;

