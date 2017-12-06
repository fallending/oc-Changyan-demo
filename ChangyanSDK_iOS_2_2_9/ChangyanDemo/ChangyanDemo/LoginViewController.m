//
//  LoginViewController.m
//  ChangYanSDKTest
//
//  Created by sohu on 14-4-16.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "LoginViewController.h"
#import "ChangyanManager.h"

#define kScreenHeight      [UIScreen mainScreen].bounds.size.height
#define kScreenWidth       [UIScreen mainScreen].bounds.size.width
#define IS_OS_7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)

@interface LoginViewController ()

@property (nonatomic, strong) UIView      *panelView;
@property (nonatomic, strong) UIToolbar   *headBar;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _panelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _panelView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_panelView];
    
    if (IS_OS_7_OR_LATER) {
        _headBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    } else {
        _headBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    }
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    NSArray *items=@[cancelBtn];
    [self.headBar setItems:items];
    
    [self.panelView addSubview:_headBar];
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 50, 40)];
    userNameLabel.backgroundColor = [UIColor clearColor];
    userNameLabel.font = [UIFont systemFontOfSize:15];
    userNameLabel.textColor = [UIColor blackColor];
    userNameLabel.text = @"用户名:";
    [self.view addSubview:userNameLabel];
    
    UITextField *userNameField = [[UITextField alloc] initWithFrame:CGRectMake(70, 100, 240, 40)];
    userNameField.layer.borderColor = [UIColor grayColor].CGColor;
    userNameField.layer.borderWidth = 1;
    [self.view addSubview:userNameField];
    
    UILabel *passWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 50, 40)];
    passWordLabel.backgroundColor = [UIColor clearColor];
    passWordLabel.font = [UIFont systemFontOfSize:15];
    passWordLabel.textColor = [UIColor blackColor];
    passWordLabel.text = @"密  码:";
    [self.view addSubview:passWordLabel];
    
    UITextField *passWordField = [[UITextField alloc] initWithFrame:CGRectMake(70, 150, 240, 40)];
    passWordField.layer.borderColor = [UIColor grayColor].CGColor;
    passWordField.layer.borderWidth = 1;
    [self.view addSubview:passWordField];
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor orangeColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(70, 200, 240, 40);
    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)loginClick {
    // 次     结果   UUID           Nick
    // 第一次：[失败] 3398dddddd4533 にっぽんご
    // 第二次：[成功] 3398dddddd4533 にっぽんごddd
    
    // 第一次：[失败] 339ddd8dddddd4533 ウチナーグチ
    // 第二次：[成功] 339ddd8dddddd4533 ウチナーaグチ
    
    
//    [[ChangyanManager sharedInstance].user loginWithUUID:@"3398dddddd4533" username:@"にっぽんご" imageUrl:@"http://sucimg.itc.cn/avatarimg/253473308_1434154914604_c175"
//
    [[ChangyanManager sharedInstance].user loginWithUUID:@"339ddd8dddddd4533" username:@"ウチナーaグチ" imageUrl:@"http://sucimg.itc.cn/avatarimg/253473308_1434154914604_c175"
     
     
     
                                                 success:^(UserManager *user) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"登陆成功!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } failure:^(NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"登陆失败!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
