//
//  DCAppDelegate.m
//  DailycredExample
//
//  Created by Hank Stoever on 12/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DCAppDelegate.h"

#import "DCViewController.h"
#import "DCUserViewController.h"
#import "DCClient.h"

@implementation DCAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize userViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [DCClient initWithClientId:@"04e0586a-7e1e-4f10-8207-304bc048050d" andClientSecret:@"9c558f4d-23e5-47cf-9ed4-23f45a165262-1cf47ecf-c2ff-492e-919f-9986c39d66b4" withRedirectUri:@"dailycredexampleapp://localhost"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[DCViewController alloc] initWithNibName:@"DCViewController" bundle:nil];
    self.userViewController = [[DCUserViewController alloc] initWithNibName:@"DCUserViewController" bundle:nil];
    if ([DCClient getCurrentUser] != nil){
        self.window.rootViewController = self.userViewController;
    } else {
        self.window.rootViewController = self.viewController;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{   
    NSLog(@"callback url is %@", [url absoluteString]);
    [[DCClient sharedClient] authenticateWithCallbackUrl:[url absoluteString]];
    if ([DCClient getCurrentUser] == nil){
        //there was an error or the user cancelled login
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];
    } else {
        self.window.rootViewController = self.userViewController;
        [self.userViewController updateForUser];
        [self.window makeKeyAndVisible];
    }
    NSLog(@"current user is: %@",[DCClient getCurrentUser]);
    return YES;
}

@end
