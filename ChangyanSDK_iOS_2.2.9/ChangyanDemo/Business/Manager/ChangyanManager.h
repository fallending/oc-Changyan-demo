//
//  ChangyanManager.h
//  ChangyanDemo
//
//  Created by 7 on 13/11/2017.
//  Copyright © 2017 changyan-dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangeyanDef.h"
#import "TopicManager.h"
#import "UserManager.h"

@interface ChangyanManager : NSObject

@property (nonatomic, readonly) TopicManager *topic;
@property (nonatomic, readonly) UserManager *user;

+ (instancetype)sharedInstance;

@end
