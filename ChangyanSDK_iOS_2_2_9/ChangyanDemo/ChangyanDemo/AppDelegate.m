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

- (NSInteger)getStringLengthWithString:(NSString *)string
{
    __block NSInteger stringLength = 0;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff)
         {
             if (substring.length > 1)
             {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     stringLength += 1;
                 }
                 else
                 {
                     stringLength += 1;
                 }
             }
             else
             {
                 stringLength += 1;
             }
         } else if (substring.length > 1)
         {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3)
             {
                 stringLength += 1;
             }
             else
             {
                 stringLength += 1;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff)
             {
                 stringLength += 1;
             }
             else if (0x2B05 <= hs && hs <= 0x2b07)
             {
                 stringLength += 1;
             }
             else if (0x2934 <= hs && hs <= 0x2935)
             {
                 stringLength += 1;
             }
             else if (0x3297 <= hs && hs <= 0x3299)
             {
                 stringLength += 1;
             }
             else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
             {
                 stringLength += 1;
             }
             else
             {
                 stringLength += 1;
             }
         }
     }];
    
    return stringLength;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    {
        NSString *string1 = @"你好Hello World!"; // 14
        printf("length = %ld\n", string1.length); // 14
        printf("cStringLength = %ld\n", string1.cStringLength); // 0
        printf("utf8Length = %ld\n", [string1 lengthOfBytesUsingEncoding:NSUTF8StringEncoding]); // 18
        printf("unicodeLength = %ld\n", [string1 lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]); // 28
        printf("utf16Length = %ld\n", [string1 lengthOfBytesUsingEncoding:NSUTF16StringEncoding]); // 16
        printf("utf32Length = %ld\n", [string1 lengthOfBytesUsingEncoding:NSUTF32StringEncoding]); // 56
        
        printf("\n");
        
        NSString *string2 = @"🇵🇷"; // 16
        
        printf("length = %ld\n", string2.length); // 16
        printf("cStringLength = %ld\n", string2.cStringLength); // 0
        printf("utf8Length = %ld\n", [string2 lengthOfBytesUsingEncoding:NSUTF8StringEncoding]); // 22
        printf("unicodeLength = %ld\n", [string2 lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]); // 32
        printf("utf16Length = %ld\n", [string2 lengthOfBytesUsingEncoding:NSUTF16StringEncoding]); // 32
        printf("utf32Length = %ld\n", [string2 lengthOfBytesUsingEncoding:NSUTF32StringEncoding]); // 60
        
        NSInteger length = [string2 lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        length -= (length - string2.length) / 2;
        length = (length +1) / 2;
        
        printf("chisLength = %ld\n", length); // 10
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData *data = [string2 dataUsingEncoding:enc];
        
        printf("gbkLength = %ld\n", data.length); // 20
        
        printf("完美Length = %ld\n", [self getStringLengthWithString:string2]); // 15
        
    }
    
    // 一定要用自己的 不要用demo中的
//    [ChangyanSDK registerApp:@"cysbKCuUr"
//                      appKey:@"16bd0e2533092b96e3e55958ef19d08a"
//                 redirectUrl:@"http://10.2.58.251:8081/login-success.html"
//        anonymousAccessToken:@"lRTU3LghBcOtwGzEapYEsKt69Us55p8xBPbvxZ8EhW0"];
    
    
    // 自测的 1
    [ChangyanSDK registerApp:@"cythD4QF9"
                      appKey:@"e61d1466115c008bbd17d5ace447b945"
                 redirectUrl:@"http://10.2.58.251:8081/login-success.html"
        anonymousAccessToken:@"lRTU3LghBcOtwGzEapYEsKt69Us55p8xBPbvxZ8EhW0"];
    
    // 自测的 2
//    [ChangyanSDK registerApp:@"cytiQOUlM"
//                      appKey:@"cfe6365d2dd08f920c896161204c666e"
//                 redirectUrl:@"https://www.baidu.com"
//        anonymousAccessToken:@""];
    
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
//    NSInvocation
}

@end
