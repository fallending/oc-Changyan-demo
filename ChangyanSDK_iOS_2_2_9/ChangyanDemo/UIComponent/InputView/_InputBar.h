//  参考：https://github.com/CoderZhuXH/XHInputView

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, _InputBarStyle) {
    /**
     * 普通模式：随键盘弹起，而显示；随键盘收起，而隐藏。【跟随输入框焦点】
     */
    _InputBarStyleDefault,
    /**
     * 停留模式：手动控制 显示、隐藏；显示的时候，常驻在屏幕下方。【手动控制】
     */
    _InputBarStyleStill,
};

@class _InputBar;

@protocol _InputBarDelagete <NSObject>

- (void)onConfig:(_InputBar *)inputBar;

/**
 *  @return YES 收起键盘
 */
- (BOOL)onSend:(_InputBar *)inputBar text:(NSString *)text;

@optional

/**
 
// 如果你工程中有配置IQKeyboardManager,并对_InputBar造成影响,
- (void)willShow:(_InputBar *)inputBar {
 [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
 [IQKeyboardManager sharedManager].enable = NO;
}
- (void)willHide:(_InputBar *)inputBar {
 [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
 [IQKeyboardManager sharedManager].enable = YES;
}
 
*/

- (void)willShow:(_InputBar *)inputBar;

- (void)willHide:(_InputBar *)inputBar;

- (void)onBackground:(_InputBar *)inputBar; // 仅处理，当前键盘处于弹起状态的情况

- (void)onTextChanged:(_InputBar *)inputBar text:(NSString *)text;

- (void)onMacCountTriggerred:(_InputBar *)inputBar text:(NSString *)text;

@end

@interface _InputBar : UIView

@property (nonatomic, assign)   NSInteger maxCount;

@property (nonatomic, strong)   UIFont *font;
@property (nonatomic, copy)     NSString *placeholder;
@property (nonatomic, strong)   UIColor *placeholderColor;
@property (nonatomic, strong)   UIColor *textViewBackgroundColor;

@property (nonatomic, strong)   UIColor *sendButtonBackgroundColor;
@property (nonatomic, copy)     NSString *sendButtonTitle;
@property (nonatomic, assign)   CGFloat sendButtonCornerRadius;
@property (nonatomic, strong)   UIFont *sendButtonFont;

// 创建在当前视图上下文
+ (instancetype)showWithStyle:(_InputBarStyle)style delegate:(id<_InputBarDelagete>)delegate inView:(UIView *)view;

// 创建在当前窗口
+ (instancetype)showWithStyle:(_InputBarStyle)style delegate:(id<_InputBarDelagete>)delegate;

// 移除输入视图
- (void)hide;

// 切换输入框焦点
- (void)toggleFirstResponder:(BOOL)toFirstResponder;

// 清理输入框
- (void)clear;

@end
