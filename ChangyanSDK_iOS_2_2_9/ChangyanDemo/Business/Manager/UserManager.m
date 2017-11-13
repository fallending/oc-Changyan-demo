//
//  UserManager.m
//  ChangyanDemo
//
//  Created by 7 on 09/11/2017.
//  Copyright © 2017 changyan-dev. All rights reserved.
//

#import "UserManager.h"
#import "ChangeyanDef.h"

@implementation UserManager

- (void)loginWithUUID:(NSString *)uuid username:(NSString *)username imageUrl:(NSString *)imageUrl success:(void (^)(UserManager *user))successHandler failure:(void(^)(NSError *error))failureHandler {
    NSString *sso = uuid;
    
    // 调用畅言单点登陆接口loginSSO
    [ChangyanSDK loginSSO:sso
                 userName:username
               profileUrl:@"http://test_profile_url.com"   // 个人主页
                   imgUrl:imageUrl
            completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
                if(statusCode == CYSuccess) {
                    
                    // 发送登陆成功消息
                    [[NSNotificationCenter defaultCenter] postNotificationName:kChangyanLoginNotification object:self];
                    
                    
                    
                    successHandler(self);
                } else {
                    NSError *error = [NSError errorWithDomain:ChangeyanPlatformName code:ChangeyanErrorTypeLoginError userInfo:@{@"message":@"登录失败"}];
                    
                    failureHandler(error);
                }
            }
     ];
}

@end
