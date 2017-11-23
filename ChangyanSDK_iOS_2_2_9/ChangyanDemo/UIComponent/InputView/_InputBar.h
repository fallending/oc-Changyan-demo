//  参考：https://github.com/CoderZhuXH/XHInputView

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, _InputBarStyle) {
    /**
     * 普通模式：随键盘弹起，而显示；随键盘收起，而隐藏。
     */
    _InputBarStyleDefault,
    /**
     * 停留模式：手动控制 显示、隐藏；显示的时候，常驻在屏幕下方。
     */
    _InputBarStyleStill,
};

@class _InputBar;

@protocol _InputBarDelagete <NSObject>
@optional

/**
 
//如果你工程中有配置IQKeyboardManager,并对_InputBar造成影响,
 
// _InputBar 将要显示
- (void)xhInputViewWillShow:(_InputBar *)inputBar {
 [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
 [IQKeyboardManager sharedManager].enable = NO;
}

// _InputBar 将要影藏
- (void)xhInputViewWillHide:(_InputBar *)inputBar {
 [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
 [IQKeyboardManager sharedManager].enable = YES;
}
 
*/

- (void)willShow:(_InputBar *)inputBar;

- (void)willHide:(_InputBar *)inputBar;

- (void)onClickedOutside:(_InputBar *)inputBar; // 仅处理，当前键盘处于弹起状态的情况

@end

@interface _InputBar : UIView

@property (nonatomic, assign)   id<_InputBarDelagete> delegate;

@property (nonatomic, assign)   NSInteger maxCount;

@property (nonatomic, strong)   UIFont *font;
@property (nonatomic, copy)     NSString *placeholder;
@property (nonatomic, strong)   UIColor *placeholderColor;
@property (nonatomic, strong)   UIColor *textViewBackgroundColor;

@property (nonatomic, strong)   UIColor *sendButtonBackgroundColor;
@property (nonatomic, copy)     NSString *sendButtonTitle;
@property (nonatomic, assign)   CGFloat sendButtonCornerRadius;
@property (nonatomic, strong)   UIFont *sendButtonFont;

@property (nonatomic, copy)     BOOL (^sendBlcok)(NSString *text);

+ (void)showInView:(UIView *)view
         withStyle:(_InputBarStyle)style
     configuration:(void(^)(_InputBar *inputBar))configurationHandler
              send:(BOOL(^)(NSString *text))sendHandler;

+ (void)showWithStyle:(_InputBarStyle)style
        configuration:(void(^)(_InputBar *inputBar))configurationHandler
                 send:(BOOL(^)(NSString *text))sendHandler;

- (void)hide;

- (void)clear;

@end
