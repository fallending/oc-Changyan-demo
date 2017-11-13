//
//  ChangyanManager.m
//  ChangyanDemo
//
//  Created by 7 on 13/11/2017.
//  Copyright © 2017 changyan-dev. All rights reserved.
//

#import "ChangyanManager.h"

@interface ChangyanManager () {
    TopicManager *_topic;
    UserManager *_user;
}

@end

@implementation ChangyanManager

#pragma mark -

- (TopicManager *)topic {
    if (!_topic) {
        _topic = [TopicManager new];
    }
    
    return _topic;
}

- (UserManager *)user {
    if (!_user) {
        _user = [UserManager new];
    }
    
    return _user;
}

#pragma mark -

static id _instance = nil;
+ (instancetype)sharedInstance { return [[self alloc] init]; }
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone { return  _instance; }
+ (id)copyWithZone:(struct _NSZone *)zone { return  _instance; }
+ (id)mutableCopyWithZone:(struct _NSZone *)zone { return _instance; }
- (id)mutableCopyWithZone:(NSZone *)zone { return _instance; }

@end
