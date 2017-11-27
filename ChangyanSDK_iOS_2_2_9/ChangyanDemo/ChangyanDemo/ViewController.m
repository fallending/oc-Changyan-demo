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
#import "ChangyanManager.h"
#import "_PopupWindow.h"
#import "_InputBar.h"
#import "_InputView.h"
#import <FTIndicator/FTIndicator.h>

@interface ViewController () <_InputBarDelagete>

@property (nonatomic, strong) _PopupMenu * sgAlertView;

@property (nonatomic, strong) _InputBar *inputBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"畅言测试";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 用于测试的图片
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"changyan" ofType:@"bundle"]];
    NSString *imgPath = [bundle pathForResource:@"mylogin" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    
    /************************** 新增调试入口 *************************/
    
    {
        // 1
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn addTarget:self action:@selector(onManualLogin) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setTitle:@"登录入口" forState:UIControlStateNormal];
        
        [leftBtn sizeToFit];
        UIBarButtonItem *loginBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
        [self.navigationItem setLeftBarButtonItems:@[loginBtnItem]];
        
        // 1
        UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [informationCardBtn addTarget:self action:@selector(onWorkingWithWebView) forControlEvents:UIControlEventTouchUpInside];
        [informationCardBtn setTitle:@"测试" forState:UIControlStateNormal];
        
        [informationCardBtn sizeToFit];
        UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
        
        // 2
        UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpaceBarButtonItem.width = 22;
        
        // 3
        UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [settingBtn addTarget:self action:@selector(onWorkingWithWebView) forControlEvents:UIControlEventTouchUpInside];
        [informationCardBtn setTitle:@"测试" forState:UIControlStateNormal];
        [settingBtn sizeToFit];
        UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
        
//        self.navigationItem.rightBarButtonItems  = @[informationCardItem,fixedSpaceBarButtonItem,settingBtnItem];
//
        [self.navigationItem setRightBarButtonItems:@[informationCardItem,fixedSpaceBarButtonItem,settingBtnItem]];
    }
    
    /////////////////////////////////////////////
    
    UIButton *commentViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentViewBtn.backgroundColor = [UIColor purpleColor];
    [commentViewBtn setTitle:@"请填写评论" forState:UIControlStateNormal];
    commentViewBtn.frame = CGRectMake(5, 500, 100, 40);
    [commentViewBtn addTarget:self action:@selector(onComment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentViewBtn];
    
    commentViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentViewBtn.backgroundColor = [UIColor purpleColor];
    [commentViewBtn setTitle:@"显示 2" forState:UIControlStateNormal];
    commentViewBtn.frame = CGRectMake(110, 500, 100, 40);
    [commentViewBtn addTarget:self action:@selector(onCommentShow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentViewBtn];
    
    commentViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentViewBtn.backgroundColor = [UIColor purpleColor];
    [commentViewBtn setTitle:@"隐藏 2" forState:UIControlStateNormal];
    commentViewBtn.frame = CGRectMake(215, 500, 100, 40);
    [commentViewBtn addTarget:self action:@selector(onCommentHide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentViewBtn];
    
//    __weak typeof(self) weakSelf = self;
    
    /////////////////////////////////////////////
    
    /************************** 界面接口使用 *************************/
    // 发评论按钮1
    UIView *postButton = [ChangyanSDK getPostCommentBar:CGRectMake(5, 350, 150, 30)
                                      postCommentButton:nil
                                               topicUrl:@""
                                          topicSourceID:@"20131125"
                                                topicID:nil
                                             categoryID:nil
                                             topicTitle:nil
                                                 target:self];
    
    [self.view addSubview:postButton];
    
    
    // 发评论按钮2  使用自定义UI
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 400, 150, 30)];
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
    UIButton *listBtn = [[UIButton alloc] initWithFrame:CGRectMake(170, 400, 20, 20)];
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
    
    UIView *defaultBar = [ChangyanSDK getDefaultCommentBar:CGRectMake(0, 450, 320, 40)
                                            postButtonRect:CGRectMake(10, 10, 180, 30)
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
    postCommentViewBtn.frame = CGRectMake(215, 350, 100, 40);
    [postCommentViewBtn addTarget:self action:@selector(postCommentView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postCommentViewBtn];
    
    
    // 直接获取评评论列表页
    UIButton *listCommentViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    listCommentViewBtn.backgroundColor = [UIColor blueColor];
    [listCommentViewBtn setTitle:@"评论列表页" forState:UIControlStateNormal];
    listCommentViewBtn.frame = CGRectMake(215, 400, 100, 40);
    [listCommentViewBtn addTarget:self action:@selector(listCommentView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:listCommentViewBtn];
    
    //************************** 非界面接口使用 *************************/
    UIButton *topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topicButton.backgroundColor = [UIColor orangeColor];
    [topicButton setTitle:@"获取文章" forState:UIControlStateNormal];
    topicButton.frame = CGRectMake(5, 5, 100, 40);
    [topicButton addTarget:self action:@selector(topicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topicButton];
    
    UIButton *commentCountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentCountButton.backgroundColor = [UIColor orangeColor];
    [commentCountButton setTitle:@"评论数" forState:UIControlStateNormal];
    commentCountButton.frame = CGRectMake(110, 5, 100, 40);
    [commentCountButton addTarget:self action:@selector(commentCountButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentCountButton];
    
    UIButton *commentCountsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentCountsButton.backgroundColor = [UIColor orangeColor];
    [commentCountsButton setTitle:@"批量评论数" forState:UIControlStateNormal];
    commentCountsButton.frame = CGRectMake(215, 5, 100, 40);
    [commentCountsButton addTarget:self action:@selector(commentCountsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentCountsButton];
    
    
    UIButton *commentListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentListButton.backgroundColor = [UIColor orangeColor];
    [commentListButton setTitle:@"获取评论" forState:UIControlStateNormal];
    commentListButton.frame = CGRectMake(5, 50, 100, 40);
    [commentListButton addTarget:self action:@selector(commentListButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentListButton];
    
    UIButton *replyCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    replyCommentButton.backgroundColor = [UIColor orangeColor];
    [replyCommentButton setTitle:@"获取回复" forState:UIControlStateNormal];
    replyCommentButton.frame = CGRectMake(110, 50, 100, 40);
    [replyCommentButton addTarget:self action:@selector(replyCommentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:replyCommentButton];
    
    UIButton *commentActionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentActionButton.backgroundColor = [UIColor orangeColor];
    [commentActionButton setTitle:@"顶\\踩" forState:UIControlStateNormal];
    commentActionButton.frame = CGRectMake(215, 50, 100, 40);
    [commentActionButton addTarget:self action:@selector(commentActionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentActionButton];
    
    
    UIButton *averageScoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    averageScoreButton.backgroundColor = [UIColor orangeColor];
    [averageScoreButton setTitle:@"获取平均分" forState:UIControlStateNormal];
    averageScoreButton.frame = CGRectMake(5, 100, 100, 40);
    [averageScoreButton addTarget:self action:@selector(averageScoreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:averageScoreButton];
    
    UIButton *scoreCommentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scoreCommentsButton.backgroundColor = [UIColor orangeColor];
    [scoreCommentsButton setTitle:@"评分的评论" forState:UIControlStateNormal];
    scoreCommentsButton.frame = CGRectMake(110, 100, 100, 40);
    [scoreCommentsButton addTarget:self action:@selector(scoreCommentsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scoreCommentsButton];
    
    UIButton *anonymousSubmitCommentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    anonymousSubmitCommentsButton.backgroundColor = [UIColor orangeColor];
    [anonymousSubmitCommentsButton setTitle:@"匿名评论" forState:UIControlStateNormal];
    anonymousSubmitCommentsButton.frame = CGRectMake(5, 150, 100, 40);
    [anonymousSubmitCommentsButton addTarget:self action:@selector(anonymousSubmitCommentsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:anonymousSubmitCommentsButton];
    
    UIButton *thirdPartLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdPartLoginButton.backgroundColor = [UIColor redColor];
    [thirdPartLoginButton setTitle:@"三方登录" forState:UIControlStateNormal];
    thirdPartLoginButton.frame = CGRectMake(5, 200, 100, 40);
    [thirdPartLoginButton addTarget:self action:@selector(thirdPartLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdPartLoginButton];
    
    UIButton *isvLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    isvLoginButton.backgroundColor = [UIColor redColor];
    [isvLoginButton setTitle:@"单点登录" forState:UIControlStateNormal];
    isvLoginButton.frame = CGRectMake(110, 200, 100, 40);
    [isvLoginButton addTarget:self action:@selector(isvLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:isvLoginButton];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.backgroundColor = [UIColor redColor];
    [logoutButton setTitle:@"登出" forState:UIControlStateNormal];
    logoutButton.frame = CGRectMake(215, 200, 100, 40);
    [logoutButton addTarget:self action:@selector(logoutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
    
    UIButton *submitCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitCommentButton.backgroundColor = [UIColor grayColor];
    [submitCommentButton setTitle:@"发表评论" forState:UIControlStateNormal];
    submitCommentButton.frame = CGRectMake(5, 250, 100, 40);
    [submitCommentButton addTarget:self action:@selector(submitCommentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitCommentButton];
    
    UIButton *postImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    postImageButton.backgroundColor = [UIColor grayColor];
    [postImageButton setTitle:@"上传图片" forState:UIControlStateNormal];
    postImageButton.frame = CGRectMake(110, 250, 100, 40);
    [postImageButton addTarget:self action:@selector(postImageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postImageButton];
    
    UIButton *getUserInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getUserInfoButton.backgroundColor = [UIColor grayColor];
    [getUserInfoButton setTitle:@"用户信息" forState:UIControlStateNormal];
    getUserInfoButton.frame = CGRectMake(215, 250, 100, 40);
    [getUserInfoButton addTarget:self action:@selector(getUserInfoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getUserInfoButton];
    
    UIButton *getNewReplyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getNewReplyButton.backgroundColor = [UIColor grayColor];
    [getNewReplyButton setTitle:@"用户最新回复" forState:UIControlStateNormal];
    getNewReplyButton.frame = CGRectMake(5, 300, 120, 40);
    [getNewReplyButton addTarget:self action:@selector(getNewReplyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getNewReplyButton];
    
    UIButton *getUserCommentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getUserCommentsButton.backgroundColor = [UIColor grayColor];
    [getUserCommentsButton setTitle:@"获取用户评论" forState:UIControlStateNormal];
    getUserCommentsButton.frame = CGRectMake(190, 300, 120, 40);
    [getUserCommentsButton addTarget:self action:@selector(getUserCommentsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getUserCommentsButton];
    
}

- (void)postCommentView {
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

- (void)listCommentView {
    UIViewController *listViewController = [ChangyanSDK getListCommentViewController:@""
                                                                             topicID:nil
                                                                       topicSourceID:@"20131125"
                                                                          categoryID:nil
                                                                          topicTitle:nil];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:listViewController];
    [self presentViewController:navigation animated:YES completion:^{
        
    }];
}

#pragma mark - 获取文章

- (void)topicButtonClick {
    [[ChangyanManager sharedInstance].topic loadTopicWith:@"" sourceId:@"storenews_21" success:^(TopicManager *topic) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取文章" message:topic.topicResponse  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
            
        [self presentViewController:alertController animated:YES completion:nil];
            
    } failure:^(NSError *error) {
        
    }];
}

- (void)commentCountButtonClick {
    [ChangyanSDK getCommentCount:nil topicSourceID:@"20131125" topicUrl:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"评论数" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
     }];
}

- (void)commentCountsButtonClick {
    [ChangyanSDK getCommentCounts:@"20131125,20131126,20131127" topicSourceIds:nil topicUrls:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"评论数" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}


- (void)commentListButtonClick {
    [ChangyanSDK getTopicComments:@"58776059" pageSize:@"5" pageNo:@"5" orderBy:nil style:nil depth:nil subSize:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
         NSLog(@"%@", responseStr);
         
         
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取评论" message:@"获取评论成功" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
         [alertController addAction:cancelAction];
         
         [self presentViewController:alertController animated:YES completion:nil];
     }];
}

- (void)replyCommentButtonClick {
    [ChangyanSDK getCommentReplies:@"58776059" commentID:@"129605488" pageSize:nil pageNo:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"评论的回复" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
     }];
}


- (void)commentActionButtonClick {
    [ChangyanSDK commentAction:1 topicID:@"622447800" commentID:@"706788112" completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"顶\\踩" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
         [alertController addAction:cancelAction];
         
         [self presentViewController:alertController animated:YES completion:nil];
     }];
}

- (void)averageScoreButtonClick {
    [ChangyanSDK getTopicAverageScore:@"58776059" topicSourceID:nil topicUrl:nil simple:YES completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"平均分" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
     }];
}
- (void)scoreCommentsButtonClick {
    [ChangyanSDK getTopicScoreComments:@"58776059" topicSourceID:nil topicUrl:nil count:10 completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"评分评论" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
     }];
}

- (void)anonymousSubmitCommentsButtonClick {
    [ChangyanSDK anonymousSubmitComment:@"58776059" content:@"测试评论" replyID:nil score:@"3" appType:40 picUrls:nil metadata:@"~ meta info ~" completeBlock:^(CYStatusCode statusCode, NSString *responseStr)
     {
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"匿名提交评论" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
         [alertController addAction:cancelAction];
         
         [self presentViewController:alertController animated:YES completion:nil];
     }];
}

- (void)thirdPartLoginButtonClick {
    if ([ChangyanSDK isLogin]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录" message:@"已登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [ChangyanSDK thirdPartLogin:2 completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
            if (statusCode == CYSuccess) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancelAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
}

- (void)isvLoginButtonClick {
    if ([ChangyanSDK isLogin]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"单点登录" message:@"已登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        [ChangyanSDK loginSSO:@"87654321" userName:@"kingzwt" profileUrl:nil imgUrl:nil completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
            if (statusCode == CYSuccess) {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"单点登录" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancelAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        }];
    }
}

- (void)logoutButtonClick {
    //[ChangyanSDK logout];
    NSString *str = @"已登出";
    if ([ChangyanSDK isLogin]) {
        [ChangyanSDK logout];
        str = @"登出成功";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登出" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)submitCommentButtonClick {
    [ChangyanSDK submitComment:@"58776059" content:@"新发表评论" replyID:nil score:@"5" appType:40 picUrls:nil metadata:@"- meta info -" completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交评论" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }];
}

- (void)postImageButtonClick {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"changyan" ofType:@"bundle"]];
    NSString *imgPath = [bundle pathForResource:@"mylogin" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
    [ChangyanSDK uploadAttach:imageData completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传图片" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
         NSLog(@"%@", responseStr);
     }];
}

- (void)getUserInfoButtonClick {
    [ChangyanSDK getUserInfo:^(CYStatusCode statusCode, NSString *responseStr) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取用户信息" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
     }];
}
- (void)getNewReplyButtonClick {
    [ChangyanSDK getUserNewReply:@"20" pageNo:@"1" completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取最新回复" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
     }];
}

- (void)getUserCommentsButtonClick {
    [ChangyanSDK getUserComments:@"115151422" pageSize:@"10" pageNumber:@"1" completeBlock:^(CYStatusCode statusCode, NSString *responseStr) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取用户评论" message:responseStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    
    }];
}

#pragma mark - 新增入口部分

- (void)onWorkingWithWebView {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"进入内置浏览器测试环境!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [self.navigationController pushViewController:[WebViewController new] animated:YES];
    }];
    [alertController addAction:cancelAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)onManualLogin {
    [self presentViewController:[LoginViewController new] animated:YES completion:nil];
}

- (void)onComment {
    //custom view
    _InputView * commentView = [_InputView view];
    
    //Popup custom view
    self.sgAlertView = [[_PopupWindow sharedWindow] showView:commentView animation:YES];
    
    [commentView setCancel:^{
        [[_PopupWindow sharedWindow] dismissView:self.sgAlertView Animated:YES];
    }];
    [commentView setSender:^(NSString * title){
        [[_PopupWindow sharedWindow] dismissView:self.sgAlertView Animated:YES];
        
        [[ChangyanManager sharedInstance].topic submitComment:@"58776059" content:title success:^(TopicManager *topic) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交评论" message:@"成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        } failure:^(NSError *error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交评论" message:@"失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }];
        
        
     }];
}

- (void)onCommentShow {
    
#if 0
    
    self.inputBar = [_InputBar showWithStyle:_InputBarStyleDefault delegate:self];
    
#else
    
    self.inputBar = [_InputBar showWithStyle:_InputBarStyleStill delegate:self inView:self.view];
    
#endif
}

- (void)onCommentHide {
    NSLog(@"recognizer = %@", self.view.gestureRecognizers);
    
    [self.inputBar hide];
    self.inputBar = nil;
}

#pragma mark - XHInputViewDelagete

- (void)onConfig:(_InputBar *)inputBar {
    inputBar.maxCount = 20;
    inputBar.textViewBackgroundColor = [UIColor groupTableViewBackgroundColor];
    inputBar.placeholder = @"发表你的神评论吧～最多200字";
}

- (BOOL)onSend:(_InputBar *)inputBar text:(NSString *)text {
    BOOL hideKeyboard = YES;
    
    [[ChangyanManager sharedInstance].topic submitComment:@"58776059" content:text success:^(TopicManager *topic) {
        
        [inputBar clear];
        
        if (hideKeyboard)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交评论" message:@"成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交评论" message:@"失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    
    
    return hideKeyboard;
}

- (void)onMacCountTriggerred:(_InputBar *)inputBar text:(NSString *)text {
    [FTIndicator showToastMessage:@"已达输入上限"];
}

@end
