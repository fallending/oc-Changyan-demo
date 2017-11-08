//
//  AppDelegate.m
//  ChangYanSDKTest
//
//  Created by sohu on 14-1-13.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "AppDelegate.h"
#import "ChangyanSDK.h"
#import "LoginViewController.h"
#import <AEHybridEngine/AEHybridEngine.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 一定要用自己的 不要用demo中的
    [ChangyanSDK registerApp:@"cysbKCuUr"
                      appKey:@"16bd0e2533092b96e3e55958ef19d08a"
                 redirectUrl:@"http://10.2.58.251:8081/login-success.html"
        anonymousAccessToken:@"lRTU3LghBcOtwGzEapYEsKt69Us55p8xBPbvxZ8EhW0"];
    
    [ChangyanSDK setAllowSelfLogin:YES];
    [ChangyanSDK setLoginViewController:[[LoginViewController alloc] init]];
    
    [ChangyanSDK setAllowAnonymous:NO];
    [ChangyanSDK setAllowRate:NO];
    [ChangyanSDK setAllowUpload:YES];
    [ChangyanSDK setAllowWeiboLogin:NO];
    [ChangyanSDK setAllowQQLogin:NO];
    [ChangyanSDK setAllowSohuLogin:NO];
    
    [ChangyanSDK setNavigationBackgroundColor:[UIColor blackColor]];
    [ChangyanSDK setNavigationTintColor:[UIColor whiteColor]];
    
    NSLog(@"info.plist = %@", [[NSBundle mainBundle] infoDictionary]);
    
    [AEHybridLauncher launch];
    
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

@end
