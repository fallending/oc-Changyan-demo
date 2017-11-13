
#import <UIKit/UIKit.h>

/**
 *  Usage
 
 1. As inputAccessoryView
 self.comment = [YYCommentControl yyCreatView];
 self.TextField.inputAccessoryView = self.comment;
 
 2. As sub view
 
 
 3. As bottom popup
 
 */

@interface _CommentView : UIView

@property (copy, nonatomic) void (^ cancel)(void);
@property (copy, nonatomic) void (^ sender)(NSString * title);

@property (weak, nonatomic) IBOutlet UITextView *TextView;

+ (instancetype)view;

@end
