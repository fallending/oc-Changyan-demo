
#import "_InputView.h"

#define  YYColor(x,y,z)  [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

@implementation _InputView

+ (instancetype)view {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.layer.borderWidth = 1.6;
    self.textView.layer.borderColor = YYColor(173, 210, 252).CGColor;
    self.textView.layer.cornerRadius = 3;
}

- (IBAction)cancel:(UIButton *)sender {
    self.cancel();
}

- (IBAction)send:(UIButton *)sender {
    self.sender([NSString stringWithFormat:@"%@", self.textView.text]);
}

- (NSNumber *)preferredHeight { // 加入 UIView 的 类别协议
    return @(130);
}

@end
