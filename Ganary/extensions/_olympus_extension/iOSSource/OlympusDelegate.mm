#import "OlympusDelegate.h"
@implementation OlympusDelegate

NSString *intent = @"uninitialized";

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options{
    NSString *message = @"Hello, world!";
    NSLog(@"%@", message);
    if ([url.scheme isEqualToString:(@"firebase-game-loop")] || [url.scheme hasSuffix:(@"echo")]) {
        //Log the scheme
        NSLog(@"Scheme: %@", url.scheme);

        // Get the path to the Documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        // Create the path for the GameLoopResults directory
        NSString *logDirectory = [documentsDirectory stringByAppendingPathComponent:@"GameLoopResults"];
        
        // Check if the directory exists, if not, create it
        if (![[NSFileManager defaultManager] fileExistsAtPath:logDirectory]) {
            NSError *error;
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
