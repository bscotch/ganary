#import "OlympusDelegate.h"
@implementation OlympusDelegate

NSString *intent = @"uninitialized";

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options{
    NSString *message = @"Hello, world!";
    NSLog(@"%@", message);
    if ([url.scheme isEqualToString:(@"firebase-game-loop")]) {
        NSLog(@"launching in firebase");
        intent = [url.scheme copy];
    }
    else{
        NSLog(@"launching in normal mode");
        intent = @"normal-launch";
    }
}


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

    // Check if any superclasses implement this method and call it
    if([[self superclass] instancesRespondToSelector:@selector(application:willFinishLaunchingWithOptions:)])
      return [super application:application willFinishLaunchingWithOptions:launchOptions];
    else
        return TRUE;
}

+ (NSString*) get_intent
{
    return intent;
}

@end
