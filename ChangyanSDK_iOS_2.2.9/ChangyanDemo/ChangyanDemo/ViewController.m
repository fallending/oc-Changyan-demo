//
//  ViewController.m
//  ChangYanSDKTest
//
//  Created by sohu on 14-1-13.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ViewController.h"
#import "ChangyanSDK.h"
#import "LoginViewController.h"
#import "WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"畅言测试";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 用于测试的图片
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"changyan" ofType:@"bundle"]];
    NSString *imgPath = [bundle pathForResource:@"mylogin" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    
    /************************** 界面接口使用 *************************/
    // 发评论按钮1
    UIView *postButton = [ChangyanSDK getPostCommentBar:CGRectMake(5, 400, 150, 30)
                                      postCommentButton:nil
                                               topicUrl:@""
                                          topicSourceID:@"20131125"
                                                topicID:nil
                                             categoryID:nil
                                             topicTitle:nil
                                                 target:self];
    
    [self.view addSubview:postButton];
    
    
    // 发评论按钮2  使用自定义UI
    
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 450, 150, 30)];
    [btn setTitle:@"大家来说说" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    postButton.layer.borderColor = [[UIColor grayColor] CGColor];
    
    UIView *postButton1 = [ChangyanSDK getPostCommentBar:btn.frame
                                       postCommentButton:btn
                                                topicUrl:@""
                                           topicSourceID:@"20131125"
                                                 topicID:nil
                                              categoryID:nil
                                              topicTitle:nil
                                                  target:self];
    
    [self.view addSubview:postButton1];
    
    // 评论列表按钮1
    UIView *listButton = [ChangyanSDK getListCommentBar:CGRectMake(170, 400, 30, 30)
                                      listCommentButton:nil
                                               topicUrl:@""
                                          topicSourceID:@"20131125"
                                                topicID:nil
                                             categoryID:nil
                                             topicTitle:nil
                                                 target:self];
    
    [self.view addSubview:listButton];
    
    // 评论列表按钮2   使用自定义UI
    UIButton *listBtn = [[UIButton alloc] initWithFrame:CGRectMake(170, 450, 20, 20)];
    [listBtn setBackgroundImage:image forState:UIControlStateNormal];
    listBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    
    
    UIView *listButton1 = [ChangyanSDK getListCommentBar:listBtn.frame
                                       listCommentButton:listBtn
                                                topicUrl:@""
                                           topicSourceID:@"20131125"
                                                 topicID:nil
                                              categoryID:nil
                                              topicTitle:nil
                                                  target:self];
    
    [self.view addSubview:listButton1];
    
    // 默认评论bar 使用默认的UI 获取包括评论和评论列表组件
    
    UIView *defaultBar = [ChangyanSDK getDefaultCommentBar:CGRectMake(0, 500, 320, 40)
                                            postButtonRect:CGRectMake(10, 10, 230, 30)
                                            listButtonRect:CGRectMake(260, 10, 30, 30)
                                                  topicUrl:@""
                                             topicSourceID:@"20131125"
                                                   topicID:nil
                                                categoryID:nil
                                                topicTitle:nil
                                                    target:self];
    [self.view addSubview:defaultBar];
    
    // 直接获取评论发表界面
    UIButton *postCommentViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postCommentViewBtn.backgroundColor = [UIColor blueColor];
    [postCommentViewBtn setTitle:@"获取评论页" forState:UIControlStateNormal];
    postCommentViewBtn.frame = CGRectMake(215, 400, 100, 40);
    [postCommentViewBtn addTarget:self action:@selector(postCommentView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postCommentViewBtn];
    
    
    // 直接获取评评论列表页
    UIButton *listCommentViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    listCommentViewBtn.backgroundColor = [UIColor blueColor];
    [listCommentViewBtn setTitle:@"评论列表页" forState:UIControlStateNormal];
    listCommentViewBtn.frame = CGRectMake(215, 450, 100, 40);
    [listCommentViewBtn addTarget:self action:@selector(listCommentView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:listCommentViewBtn];
    
    //************************** 非界面接口使用 *************************/
    UIButton *topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topicButton.backgroundColor = [UIColor orangeColor];
    [topicButton setTitle:@"获取文章" forState:UIControlStateNormal];
    topicButton.frame = CGRectMake(5, 50, 100, 40);
    [topicButton addTarget:self action:@selector(topicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topicButton];
    
    UIButton *commentCountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentCountButton.backgroundColor = [UIColor orangeColor];
    [commentCountButton setTitle:@"评论数" forState:UIControlStateNormal];
    commentCountButton.frame = CGRectMake(110, 50, 100, 40);
    [commentCountButton addTarget:self action:@selector(commentCountButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentCountButton];
    
    UIButton *commentCountsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentCountsButton.backgroundColor = [UIColor orangeColor];
    [commentCountsButton setTitle:@"批量评论数" forState:UIControlStateNormal];
    commentCountsButton.frame = CGRectMake(215, 50, 100, 40);
    [commentCountsButton addTarget:self action:@selector(commentCountsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentCountsButton];
    
    
    UIButton *commentListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentListButton.backgroundColor = [UIColor orangeColor];
    [commentListButton setTitle:@"获取评论" forState:UIControlStateNormal];
    commentListButton.frame = CGRectMake(5, 100, 100, 40);
    [commentListButton addTarget:self action:@selector(commentListButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentListButton];
    
    UIButton *replyCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    replyCommentButton.backgroundColor = [UIColor orangeColor];
    [replyCommentButton setTitle:@"获取回复" forState:UIControlStateNormal];
    replyCommentButton.frame = CGRectMake(110, 100, 100, 40);
    [replyCommentButton addTarget:self action:@selector(replyCommentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:replyCommentButton];
    
    UIButton *commentActionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentActionButton.backgroundColor = [UIColor orangeColor];
    [commentActionButton setTitle:@"顶\\踩" forState:UIControlStateNormal];
    commentActionButton.frame = CGRectMake(215, 100, 100, 40);
    [commentActionButton addTarget:self action:@selector(commentActionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentActionButton];
    
    
    UIButton *averageScoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    averageScoreButton.backgroundColor = [UIColor orangeColor];
    [averageScoreButton setTitle:@"获取平均分" forState:UIControlStateNormal];
    averageScoreButton.frame = CGRectMake(5, 150, 100, 40);
    [averageScoreButton addTarget:self action:@selector(averageScoreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:averageScoreButton];
    
    UIButton *scoreCommentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scoreCommentsButton.backgroundColor = [UIColor orangeColor];
    [scoreCommentsButton setTitle:@"评分的评论" forState:UIControlStateNormal];
    scoreCommentsButton.frame = CGRectMake(110, 150, 100, 40);
    [scoreCommentsButton addTarget:self action:@selector(scoreCommentsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scoreCommentsButton];
    
    UIButton *anonymousSubmitCommentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    anonymousSubmitCommentsButton.backgroundColor = [UIColor orangeColor];
    [anonymousSubmitCommentsButton setTitle:@"匿名评论" forState:UIControlStateNormal];
    anonymousSubmitCommentsButton.frame = CGRectMake(5, 200, 100, 40);
    [anonymousSubmitCommentsButton addTarget:self action:@selector(anonymousSubmitCommentsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:anonymousSubmitCommentsButton];
    
    UIButton *thirdPartLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdPartLoginButton.backgroundColor = [UIColor redColor];
    [thirdPartLoginButton setTitle:@"三方登录" forState:UIControlStateNormal];
    thirdPartLoginButton.frame = CGRectMake(5, 250, 100, 40);
    [thirdPartLoginButton addTarget:self action:@selector(thirdPartLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdPartLoginButton];
    
    UIButton *isvLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    isvLoginButton.backgroundColor = [UIColor redColor];
    [isvLoginButton setTitle:@"单点登录" forState:UIControlStateNormal];
    isvLoginButton.frame = CGRectMake(110, 250, 100, 40);
    [isvLoginButton addTarget:self action:@selector(isvLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:isvLoginButton];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.backgroundColor = [UIColor redColor];
    [logoutButton setTitle:@"登出" forState:UIControlStateNormal];
    logoutButton.frame = CGRectMake(215, 250, 100, 40);
    [logoutButton addTarget:self action:@selector(logoutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
    
    UIButton *submitCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitCommentButton.backgroundColor = [UIColor grayColor];
    [submitCommentButton setTitle:@"发表评论" forState:UIControlStateNormal];
    submitCommentButton.frame = CGRectMake(5, 300, 100, 40);
    [submitCommentButton addTarget:self action:@selector(submitCommentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitCommentButton];
    
    UIButton *postImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    postImageButton.backgroundColor = [UIColor grayColor];
    [postImageButton setTitle:@"上传图片" forState:UIControlStateNormal];
    postImageButton.frame = CGRectMake(110, 300, 100, 40);
    [postImageButton addTarget:self action:@selector(postImageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postImageButton];
    
    UIButton *getUserInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getUserInfoButton.backgroundColor = [UIColor grayColor];
    [getUserInfoButton setTitle:@"用户信息" forState:UIControlStateNormal];
    getUserInfoButton.frame = CGRectMake(215, 300, 100, 40);
    [getUserInfoButton addTarget:self action:@selector(getUserInfoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getUserInfoButton];
    
    UIButton *getNewReplyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getNewReplyButton.backgroundColor = [UIColor grayColor];
    [getNewReplyButton setTitle:@"用户最新回复" forState:UIControlStateNormal];
    getNewReplyButton.frame = CGRectMake(5, 350, 120, 40);
    [getNewReplyButton addTarget:self action:@selector(getNewReplyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getNewReplyButton];
    
    UIButton *getUserCommentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getUserCommentsButton.backgroundColor = [UIColor grayColor];
    [getUserCommentsButton setTitle:@"获取用户评论" forState:UIControlStateNormal];
    getUserCommentsButton.frame = CGRectMake(190, 350, 120, 40);
    [getUserCommentsButton addTarget:self action:@selector(getUserCommentsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getUserCommentsButton];
    
}

- (void)postCommentView
{
    UIViewController *postViewController = [ChangyanSDK getPostCommentViewController:@"http://test/topic/test.html"
                                                                             topicID:nil
                                                                       topicSourceID:@"20131125"
                                                                          categoryID:nil
                                                                          topicTitle:nil
                                                                    replyPlaceHolder:@"说......说......说两句吧!"];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:postViewController];
    [self presentViewController:navigation animated:YES completion:^{
    }];
}

- (void)listCommentView
{
    UIViewController *listViewController = [ChangyanSDK getListCommentViewController:@""
                                                                             topicID:nil
                                                                       topicSourceID:@"20131125"
                                                                          categoryID:nil
                                                                          topicTitle:nil];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:listViewController];
    [self presentViewController:navigation animated:YES completion:^{
        
    }];
}


- (void)topicButtonClick
{
    [self.navigationController pushViewController:[WebViewController new] animated:YES];
    
    /////////////////////////////////////
    
//    [ChangyanSDK loadTopic:@"" topicTitle:nil topicSourceID:@"storenews_21" topicCategoryID:nil pageSize:@"20" hotSize:@"3" orderBy:nil style:nil depth:nil subSize:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
//     {
//         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取文章"
//                                                         message:responseStr
//                                                        delegate:nil
//                                               cancelButtonTitle:@"确定"
//                                               otherButtonTitles:nil];
//         [alert show];
//     }];
}

- (void)commentCountButtonClick
{
    [ChangyanSDK getCommentCount:nil topicSourceID:@"20131125" topicUrl:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"评论数"
                                                         message:responseStr
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
         [alert show];
     }];
}

- (void)commentCountsButtonClick
{
    [ChangyanSDK getCommentCounts:@"20131125,20131126,20131127" topicSourceIds:nil topicUrls:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"评论数"
                                                        message:responseStr
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}


- (void)commentListButtonClick
{
    [ChangyanSDK getTopicComments:@"58776059" pageSize:@"5" pageNo:@"5" orderBy:nil style:nil depth:nil subSize:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取评论"
                                                         message:@"获取评论成功"
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
         [alert show];
         NSLog(@"%@", responseStr);
     }];
}

- (void)replyCommentButtonClick
{
    [ChangyanSDK getCommentReplies:@"58776059" commentID:@"129605488" pageSize:nil pageNo:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"评论的回复"
                                                         message:responseStr
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
         [alert show];
     }];
}


- (void)commentActionButtonClick
{
    [ChangyanSDK commentAction:1 topicID:@"622447800" commentID:@"706788112" completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
     {
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"顶\\踩"
                                                         message:responseStr
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
         [alert show];
     }];
}


- (void)averageScoreButtonClick
{
    [ChangyanSDK getTopicAverageScore:@"58776059" topicSourceID:nil topicUrl:nil simple:YES completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"平均分"
                                                         message:responseStr
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
         [alert show];
     }];
}
- (void)scoreCommentsButtonClick
{
    [ChangyanSDK getTopicScoreComments:@"58776059" topicSourceID:nil topicUrl:nil count:10 completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"评分评论"
                                                         message:responseStr
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
         [alert show];
     }];
}

- (void)anonymousSubmitCommentsButtonClick
{
    [ChangyanSDK anonymousSubmitComment:@"58776059" content:@"测试评论" replyID:nil score:@"3" appType:40 picUrls:nil metadata:@"~ meta info ~" completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"匿名提交评论"
                                                         message:responseStr
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
         [alert show];
     }];
}

- (void)thirdPartLoginButtonClick
{
    if ([ChangyanSDK isLogin])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录"
                                                        message:@"已登录"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [ChangyanSDK thirdPartLogin:2 completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
            if (statusCode == CYSuccess)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录"
                                                                message:responseStr
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
}

- (void)isvLoginButtonClick
{
    if ([ChangyanSDK isLogin])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"单点登录"
                                                        message:@"已登录"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [ChangyanSDK loginSSO:@"87654321" userName:@"kingzwt" profileUrl:nil imgUrl:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
            if (statusCode == CYSuccess)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"单点登录"
                                                                message:responseStr
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
}

- (void)logoutButtonClick
{
    //[ChangyanSDK logout];
    NSString *str = @"已登出";
    if ([ChangyanSDK isLogin]) {
        [ChangyanSDK logout];
        str = @"登出成功";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登出"
                                                    message:str
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    
}

- (void)submitCommentButtonClick
{
    [ChangyanSDK submitComment:@"58776059" content:@"新发表评论" replyID:nil score:@"5" appType:40 picUrls:nil metadata:@"- meta info -" completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提交评论"
                                                        message:responseStr
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)postImageButtonClick
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"changyan" ofType:@"bundle"]];
    NSString *imgPath = [bundle pathForResource:@"mylogin" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
    [ChangyanSDK uploadAttach:imageData completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"上传图片"
                                                         message:responseStr
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
         [alert show];
         NSLog(@"%@", responseStr);
     }];
}

- (void)getUserInfoButtonClick
{
    [ChangyanSDK getUserInfo:^(CYStatusCode statusCode, NSString *responseStr)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取用户信息"
                                                         message:responseStr
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
         [alert show];
     }];
}
- (void)getNewReplyButtonClick
{
    [ChangyanSDK getUserNewReply:@"20" pageNo:@"1" completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取最新回复"
                                                         message:responseStr
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
         [alert show];
     }];
}

- (void)getUserCommentsButtonClick
{
    [ChangyanSDK getUserComments:@"115151422" pageSize:@"10" pageNumber:@"1" completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取用户评论"
                                                        message:responseStr
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

@end
