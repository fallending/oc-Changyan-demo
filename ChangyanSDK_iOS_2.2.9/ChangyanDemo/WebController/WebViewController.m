//
//  WebViewController.m
//  ChangyanDemo
//
//  Created by 7 on 07/11/2017.
//  Copyright © 2017 changyan-dev. All rights reserved.
//

#import "WebViewController.h"

#import <objc/runtime.h>

@interface AESJSCallBack : NSObject

@property (nonatomic, copy) NSString *succeedCallBack;

@property (nonatomic, copy) NSString *failureCallBack;

+ (instancetype)callBackWithRawData:(NSDictionary *)data;

@end

@implementation AESJSCallBack

+ (instancetype)callBackWithRawData:(NSDictionary *)data {
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    AESJSCallBack *callBack = [[AESJSCallBack alloc] init];
    callBack.succeedCallBack = [data objectForKey:@"success_callback"];
    callBack.failureCallBack = [data objectForKey:@"fail_callback"];
    
    return callBack;
}

@end

#pragma mark -

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet AEWebViewContainer *webView;

@property (nonatomic, strong) AEJavaScriptHandler *handler;

@property (nonatomic, strong) NSArray *tableArray;

@end

@implementation WebViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Web测试";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *extInfo = [NSString stringWithFormat:@"esports-platform/iPhone/%@", appVersion];
    NSString *jsBridgeInfo = @"Alisports-JSBridge/iPhone/2.0.0";
    NSString *newUserAgent = [NSString stringWithFormat:@"%@ %@", extInfo, jsBridgeInfo];
    
//    [self.webView setWebViewType:AEWebViewContainTypeUIWebView];
    
    [self.webView setupCustomUserAgent:newUserAgent completionHandler:^(NSString *userAgent) {
        NSLog(@"User agent has been setup./n%@", userAgent);
    }];
    
    self.handler = [[AEJavaScriptHandler alloc] init];
    
    {
        AEJSHandlerContext *instanceSelContext = [AEJSHandlerContext contextWithPerformer:self selector:NSSelectorFromString(@"aesCloseWebView:") aliasName:@"aesCloseWebView"];
        
        [self.handler addJSContexts:[NSSet setWithObjects:instanceSelContext, nil]];
    }
    
    [self.webView setJavaScriptHandler:self.handler];
    
    NSHTTPCookie *cookie1 = [NSHTTPCookie cookieWithProperties:@{NSHTTPCookieName:@"TestCookieName1", NSHTTPCookieValue:@"TestCookieValue1", NSHTTPCookieDomain:@"alisports.com", NSHTTPCookiePath:@"/"}];
    NSHTTPCookie *cookie2 = [NSHTTPCookie cookieWithProperties:@{NSHTTPCookieName:@"TestCookieName2", NSHTTPCookieValue:@"TestCookieValue2", NSHTTPCookieDomain:@"alisports.com", NSHTTPCookiePath:@"/"}];
    [self.webView setCookies:@[cookie1, cookie2]];
    
    __unused NSString *testUrlString2 = @"http://testesports.alisports.com/static/demo/jsbridge.html";
    NSString *testUrlString3 = @"http://testesports.alisports.com/static/demo/jsbridge1.0.0.html";
    NSURL *indexUrl = [NSURL URLWithString:testUrlString3];
    
    __unused NSString *index = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"Html"];
//    NSURL *indexUrl = [NSURL fileURLWithPath:index];
    [self.webView loadRequest:[NSURLRequest requestWithURL:indexUrl]];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self.webView setCookies:nil];
    //    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)aesLogin:(id)body {
    
}

- (void)aesShare:(id)body {
    
}

- (void)aesCloseWebView:(id)body {
    __weak typeof(self) weakSelf = self;;
    [weakSelf handleJSParam:body withResult:^(NSDictionary *jsCallBody, AESJSCallBack *callBack) {
        NSString *str = jsCallBody[@"title"];
        weakSelf.navigationItem.title = str;
    }];
}

- (void)testInstanceFunctionName:(NSString *)name var:(NSString *)var {
    NSString *functionName = [NSString stringWithUTF8String:__FUNCTION__];
    functionName = [[functionName componentsSeparatedByString:@" "] lastObject];
    functionName = [functionName substringToIndex:[functionName length] - 1];
    NSLog(@"%@", functionName);
    NSLog(@"%@", self);
}

- (void)testInstanceFunctionName2:(NSString *)name var2:(NSString *)var {
    
}

+ (void)testClassFunctionName2:(NSString *)name var2:(NSString *)var {
    
}

+ (void)testClassFunctionName:(NSString *)name var:(NSString *)va {
    NSString *functionName = [NSString stringWithUTF8String:__FUNCTION__];
    functionName = [[functionName componentsSeparatedByString:@" "] lastObject];
    functionName = [functionName substringToIndex:[functionName length] - 1];
    NSLog(@"%@", functionName);
    NSLog(@"%@", self);
}

- (void)aesSetTitle:(id)body {
    __weak typeof(self) weakSelf = self;;
    [weakSelf handleJSParam:body withResult:^(NSDictionary *jsCallBody, AESJSCallBack *callBack) {
        NSString *str = jsCallBody[@"title"];
        weakSelf.navigationItem.title = str;
    }];
}

- (void)handleJSParam:(id)param withResult:(void (^)(NSDictionary *, AESJSCallBack *))result {
    if (!result) {
        return;
    }
    if (!param || ![param isKindOfClass:[NSDictionary class]]) {
        result(nil, nil);
        return;
    }
    NSDictionary *jsParam = [param objectForKey:@"parameter"];
    if (![jsParam isKindOfClass:[NSDictionary class]]) {
        jsParam = nil;
    }
    NSDictionary *callBackData = [param objectForKey:@"callback"];
    AESJSCallBack *callBack = [AESJSCallBack callBackWithRawData:callBackData];
    result(jsParam, callBack);
}

@end

