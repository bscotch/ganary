// Custom URL handling for the game-loop / echo intents.
//
// With the UIScene move, URL opens are delivered to the runner's SCENE
// delegate (iPad_RunnerSceneDelegate) rather than the app delegate, so this
// class now subclasses the scene delegate instead of iPad_RunnerAppDelegate.
// Wire it up via UISceneDelegateClassName in the Info.plist.
#import "iPad_RunnerSceneDelegate.h"

API_AVAILABLE(ios(13.0))
@interface OlympusSceneDelegate : iPad_RunnerSceneDelegate

+ (NSString *)get_intent;

@end
