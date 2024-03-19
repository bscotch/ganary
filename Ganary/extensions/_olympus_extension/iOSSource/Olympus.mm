#import "Olympus.h"
#import "OlympusDelegate.h"
@implementation Olympus
- (void)_olympus_ios_finish_loop {

  NSLog(@"_olympus_ios_finish_loop");
  UIApplication *app = [UIApplication sharedApplication];
  [app openURL:[NSURL URLWithString:@"firebase-game-loop-complete://"]
      options:@{}
completionHandler:^(BOOL success) {}];
}

- (NSString*) _olympus_ios_get_init_confirmation
{
    NSString *value = @"initialized";
    return value;
}


- (NSString*) _olympus_ios_get_intent
{
    NSString *value = [OlympusDelegate get_intent];
    return value;
}
@end
