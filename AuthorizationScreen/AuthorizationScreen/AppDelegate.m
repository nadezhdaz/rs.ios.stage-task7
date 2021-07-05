//
//  AppDelegate.m
//  AuthorizationScreen
//
//  Created by Надежда Зенкова on 03.07.2021.
//

#import "AppDelegate.h"
#import "AuthorizationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    AuthorizationViewController *rootViewController = [[AuthorizationViewController alloc] initWithNibName:@"AuthorizationViewController" bundle:nil];
    window.rootViewController = rootViewController;
    [window setRootViewController:rootViewController];
    
    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
