#import <QuartzCore/QuartzCore.h>
#import "_PopupMenu.h"

#define kMAX_ALERT_MESSAGE_HEIGHT   300

@interface _PopupMenu () {
    CGRect _sgAlertViewRect;
}

@end

@implementation _PopupMenu

- (id)initWithAlertView:(UIView *) alertView andMainView: (UIView *)mainView andHeight:(int) height {
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (self) {
        [self setupView:alertView andMainView:mainView andHeight: height];
    }
    
    return self;
}

- (void)setupView:(UIView *)alertView andMainView:(UIView *)mainView andHeight: (int)height {
    _height = height;

    [self addSubview:alertView];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bounds = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, _height)};
}


@end
