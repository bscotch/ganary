#import "OlympusDelegate.h"

@implementation OlympusSceneDelegate

static NSString *intent = @"uninitialized";

// Cold launch (app was NOT already running): UIKit delivers the launch URL(s)
// here via connectionOptions.URLContexts, not through openURLContexts:. We must
// let the runner build its window / RunnerViewController / EAGLView first, then
// inspect the URL(s) ourselves. This runs at scene-connect time, so the intent
// is set well before the game reads it via +get_intent — independent of the
// GameMaker extension setup timing.
- (void)scene:(UIScene *)scene
    willConnectToSession:(UISceneSession *)session
                 options:(UISceneConnectionOptions *)connectionOptions
{
    [super scene:scene willConnectToSession:session options:connectionOptions];

    for (UIOpenURLContext *ctx in connectionOptions.URLContexts) {
        [self handleURL:ctx.URL];
    }
}

// Warm open (app already running). Call super so the runner still forwards the
// URL to any GameMaker extensions implementing onOpenURL:sourceApplication:annotation:.
- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts
{
    [super scene:scene openURLContexts:URLContexts];

    for (UIOpenURLContext *ctx in URLContexts) {
        [self handleURL:ctx.URL];
    }
}

// Original openURL logic, moved verbatim off application:openURL:options:.
- (void)handleURL:(NSURL *)url
{
    NSString *message = @"Hello, world!";
    NSLog(@"%@", message);

    if ([url.scheme isEqualToString:@"firebase-game-loop"] || [url.scheme hasSuffix:@"echo"]) {
        // Log the scheme
        NSLog(@"Scheme: %@", url.scheme);

        // Get the path to the Documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];

        // Create the path for the GameLoopResults directory
        NSString *logDirectory = [documentsDirectory stringByAppendingPathComponent:@"GameLoopResults"];

        // Check if the directory exists, if not, create it
        if (![[NSFileManager defaultManager] fileExistsAtPath:logDirectory]) {
            NSError *error=nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:logDirectory withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"Failed to create log directory: %@", error.localizedDescription);
            }
        }

        // Create the path for the log file inside the GameLoopResults directory
        NSString *logPath = [logDirectory stringByAppendingPathComponent:@"logfile.txt"];

        // Redirect stdout and stderr to the log file
        freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "w+", stderr);
        freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "w+", stdout);

        // Optional: NSLog to confirm that it works
        NSLog(@"Logging to file at path: %@", logPath);
        intent = [url.scheme copy];
    } else {
        NSLog(@"launching in normal mode");
        intent = @"normal-launch";
    }
}

+ (NSString *)get_intent
{
    return intent;
}

@end
