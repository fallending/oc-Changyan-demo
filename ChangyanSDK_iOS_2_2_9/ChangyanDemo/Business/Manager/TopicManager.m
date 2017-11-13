//
//  TopicManager.m
//  ChangyanDemo
//
//  Created by 7 on 09/11/2017.
//  Copyright © 2017 changyan-dev. All rights reserved.
//

#import "TopicManager.h"
#import "ChangeyanDef.h"

@implementation TopicManager

// pageSize:@"20" hotSize:@"3"

- (void)loadTopicWith:(NSString *)sourceUrl sourceId:(NSString *)sourceId success:(void(^)(TopicManager *topic))successHandler failure:(void(^)(NSError *error))failureHandler {
    [ChangyanSDK loadTopic:sourceUrl topicTitle:nil topicSourceID:sourceId  topicCategoryID:nil pageSize:@"1" hotSize:@"1" orderBy:nil style:nil depth:nil subSize:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        
        if (statusCode == CYSuccess) {
            
            self.topicResponse = responseStr;
            
            successHandler(self);
        } else {
            failureHandler(nil);
        }
    }];
}

- (void)submitComment:(NSString *)topicId content:(NSString *)content success:(void(^)(TopicManager *topic))successHandler failure:(void(^)(NSError *error))failureHandler {
    [ChangyanSDK submitComment:topicId content:content replyID:nil score:@"5" appType:40/** iOS 平台 */ picUrls:nil metadata:@"- meta info -" completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        
        if (statusCode == CYSuccess) {
            successHandler(self);
        } else {
            failureHandler(nil);
        }
        
    }];
}

@end
