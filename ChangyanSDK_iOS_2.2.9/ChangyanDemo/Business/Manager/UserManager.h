//
//  UserManager.h
//  ChangyanDemo
//
//  Created by 7 on 09/11/2017.
//  Copyright © 2017 changyan-dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

// 登录
- (void)loginWithUUID:(NSString *)uuid username:(NSString *)username imageUrl:(NSString *)imageUrl success:(void (^)(UserManager *user))successHandler failure:(void(^)(NSError *error))failureHandler;

// 获取用户信息

@end
