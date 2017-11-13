//
//  TopicManager.h
//  ChangyanDemo
//
//  Created by 7 on 09/11/2017.
//  Copyright © 2017 changyan-dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicManager : NSObject

// 加载文章
@property (nonatomic, strong) NSString *topicResponse;

- (void)loadTopicWith:(NSString *)sourceUrl sourceId:(NSString *)sourceId success:(void(^)(TopicManager *topic))successHandler failure:(void(^)(NSError *error))failureHandler;

// 提交评论
- (void)submitComment:(NSString *)topicId content:(NSString *)content success:(void(^)(TopicManager *topic))successHandler failure:(void(^)(NSError *error))failureHandler;

@end
