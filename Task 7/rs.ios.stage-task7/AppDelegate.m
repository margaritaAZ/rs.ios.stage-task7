//
//  AppDelegate.m
//  rs.ios.stage-task7
//
//  Created by Маргарита Жучик on 2.07.21.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *rootVC = [[ViewController alloc] init];
    window.rootViewController = rootVC;
    self.window = window;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
