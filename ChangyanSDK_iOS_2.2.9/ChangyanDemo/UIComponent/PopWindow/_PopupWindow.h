#import <UIKit/UIKit.h>

@class _PopupMenu;

@interface _PopupWindow : UIView

+ (_PopupWindow *)sharedWindow;

//显示
- (_PopupMenu *)showView:(UIView *)menu animation:(BOOL)animated;

//移除
- (void)dismissView:(_PopupMenu *)menu Animated:(BOOL)animated;


@end
