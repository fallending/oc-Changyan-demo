#import <UIKit/UIKit.h>

@interface _PopupMenu : UIView {
    int _height;
}

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

- (id)initWithAlertView:(UIView *) alertView andMainView: (UIView *) mainView andHeight:(int) height ;

@end
