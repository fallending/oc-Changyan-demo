
#import <UIKit/UIKit.h>

/**
 *  Usage
 
 1. As inputAccessoryView
 self.input = [_InputView yyCreatView];
 self.TextField.inputAccessoryView = self.input;
 
 2. As sub view
 
 
 3. As bottom popup
 
 */

@interface _InputView : UIView

@property (copy, nonatomic) void (^ cancel)(void);
@property (copy, nonatomic) void (^ sender)(NSString *text);

@property (weak, nonatomic) IBOutlet UITextView *textView;

+ (instancetype)view;

@end
