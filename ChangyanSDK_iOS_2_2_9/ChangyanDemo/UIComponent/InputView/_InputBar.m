#import "_InputBar.h"

#define kScreenW    [UIScreen mainScreen].bounds.size.width
#define kScreenH    [UIScreen mainScreen].bounds.size.height

#define kStyleLarge_LRSpace 10
#define kStyleLarge_TBSpace 8
#define kStyleDefault_LRSpace 10
#define kStyleDefault_TBSpace 8
#define kCountLabHeight 20

#define kTextViewCornerRadius 4.f

#define kTextViewHolderBackgroundColor [UIColor colorWithRed:250/255.f green:250/255.f blue:250/255.f alpha:1.0]

#define kPlaceholderColor [UIColor colorWithRed:170/255.f green:170/255.f blue:170/255.f alpha:1]
#define kInputBarBorderColor [UIColor colorWithRed:191/255.f green:191/255.f blue:191/255.f alpha:1]
#define kInputTextViewBorderColor [UIColor colorWithRed:235/255.f green:235/255.f blue:235/255.f alpha:1]
#define kInputTextViewBackgroundColor [UIColor colorWithRed:252/255.f green:252/255.f blue:252/255.f alpha:1]

#define kSendButtonNormalTitleColor [UIColor colorWithRed:90/255.f green:90/255.f blue:90/255.f alpha:1]
#define kSendButtonDisableTitleColor [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1]

#define kStyleDefault_Height 44

static CGFloat keyboardAnimationDuration = 0.3;
CGFloat SuperViewHeight = 0.f;

@interface _InputBar() <UITextViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) _InputBarStyle style;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *textBackgroundView;
@property (nonatomic, strong) UIView *textBackgroundTopBorderView;

@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, assign) CGRect showFrameDefault;
@property (nonatomic, assign) CGRect sendButtonFrameDefault;
@property (nonatomic, assign) CGRect textViewFrameDefault;

@property (nonatomic, assign) BOOL willHide; // 将要隐藏标志

@property (nonatomic, weak) UIView *viewWithTapRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@end

@implementation _InputBar

#pragma mark - Public Method

+ (instancetype)showWithStyle:(_InputBarStyle)style
        configuration:(void(^)(_InputBar *inputBar))configurationHandler
                 send:(BOOL(^)(_InputBar *, NSString *text))sendHandler {
    SuperViewHeight = kScreenH;
    
    _InputBar *inputBar = [[_InputBar alloc] initWithStyle:style];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    [window addSubview:inputBar.backgroundView];
    [window addSubview:inputBar];
    
    if(configurationHandler) configurationHandler(inputBar);
    
    inputBar.sendBlock = [sendHandler copy];
    
    [inputBar show:YES];
    
    return inputBar;
}

+ (instancetype)showInView:(UIView *)view
         withStyle:(_InputBarStyle)style
     configuration:(void (^)(_InputBar *))configurationHandler
              send:(BOOL (^)(_InputBar *, NSString *))sendHandler {
    SuperViewHeight = view.frame.size.height;
    
    _InputBar *inputBar = [[_InputBar alloc] initWithStyle:style];
    [inputBar setBackgroundTapRecogenizer:view];
    
    [view addSubview:inputBar];
    [view bringSubviewToFront:inputBar];
    
    if(configurationHandler) configurationHandler(inputBar);
    
    inputBar.sendBlock = [sendHandler copy];
    
    [inputBar show:NO];
    
    return inputBar;
}

- (void)hide {
    
    if([self.delegate respondsToSelector:@selector(willHide:)]) {
        [self.delegate willHide:self];
    }
    
    if (self.textView.isFirstResponder) { // 键盘在弹起态
        
        self.willHide = YES;
        
        [self.textView resignFirstResponder];
    } else {
        [self animateHide];
    }
}

- (void)clear {
    self.textView.text = nil;
    
    [self textViewDidChange:self.textView];
}

#pragma mark -

- (void)show:(BOOL)becomeFirstResponder {
    if([self.delegate respondsToSelector:@selector(willShow:)]){
        [self.delegate willShow:self];
    }
    
    _textView.text = nil;
    _placeholderLabel.hidden = NO;
    
    [self resetFrameDefault];
    
    if (becomeFirstResponder) {
        
        [_textView becomeFirstResponder];
        
        // 随键盘动画
    } else {
        // 仅仅：底部弹出动画
        [self animateShow];
    }
}

- (NSNumber *)preferredHeight { // 加入 UIView 的 类别协议
    return @(kStyleDefault_Height);
}

#pragma mark -

- (instancetype)initWithStyle:(_InputBarStyle)style {
    self = [super init];
    if (self) {
        self.style = style;
        self.backgroundColor = kTextViewHolderBackgroundColor;
        self.showFrameDefault = CGRectMake(0, kScreenH, kScreenW, kStyleDefault_Height);
        self.frame = self.showFrameDefault;
        
        [self setupStyleDefaultUI];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"_InputBar dealloc");
    NSLog(@"OUT, view = %@, tap = %@", self.viewWithTapRecognizer, self.tapRecognizer);
    [self.viewWithTapRecognizer removeGestureRecognizer:self.tapRecognizer];
    self.tapRecognizer = nil;
}

#pragma mark - private

- (void)setupStyleDefaultUI {
    CGFloat sendButtonWidth = 45;
    CGFloat sendButtonHeight = self.bounds.size.height -2*kStyleDefault_TBSpace;
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(kScreenW - kStyleDefault_LRSpace - sendButtonWidth, kStyleDefault_TBSpace,sendButtonWidth, sendButtonHeight);
    [self.sendButton setTitleColor:kSendButtonNormalTitleColor forState:UIControlStateNormal];
    [self.sendButton setTitleColor:kSendButtonDisableTitleColor forState:UIControlStateDisabled];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(onSend:) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.sendButton];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(kStyleDefault_LRSpace, kStyleDefault_TBSpace, kScreenW - 3*kStyleDefault_LRSpace - sendButtonWidth, self.bounds.size.height-2*kStyleDefault_TBSpace)];
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.backgroundColor = kInputTextViewBackgroundColor;
    self.textView.delegate = self;
    //_textView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.textView.layer.borderColor = kInputTextViewBorderColor.CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = kTextViewCornerRadius;
    [self addSubview:self.textView];
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 0, _textView.bounds.size.width-14, self.textView.bounds.size.height)];
    self.placeholderLabel.font = self.textView.font;
    self.placeholderLabel.text = @"请输入...";
    self.placeholderLabel.textColor = kPlaceholderColor;
    [_textView addSubview:self.placeholderLabel];
    
    self.sendButtonFrameDefault = self.sendButton.frame;
    self.textViewFrameDefault = self.textView.frame;
    
    {
        // 上边框
        self.textBackgroundTopBorderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0.5)];
        self.textBackgroundTopBorderView.backgroundColor = kInputBarBorderColor;
        [self addSubview:self.textBackgroundTopBorderView];
    }
}

- (void)resetFrameDefault {
        self.frame = self.showFrameDefault;
        self.sendButton.frame = self.sendButtonFrameDefault;
        self.textView.frame = self.textViewFrameDefault;
}

- (void)setBackgroundTapRecogenizer:(UIView *)view {
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundClick:)];
    self.tapRecognizer.delegate = self;
    [view addGestureRecognizer:self.tapRecognizer];
    
    self.viewWithTapRecognizer = view;
    
    NSLog(@"IN, view = %@, tap = %@", self.viewWithTapRecognizer, self.tapRecognizer);
}

- (void)textViewDidChange:(UITextView *)textView {
    if(textView.text.length) {
        self.placeholderLabel.hidden = YES;
    } else {
        self.placeholderLabel.hidden = NO;
    }
    
    if(_maxCount > 0) {
        if(textView.text.length>=_maxCount){
            textView.text = [textView.text substringToIndex:_maxCount];
        }
        
        // 更新字数提示
//        if(_style == _InputBarStyleLarge){
//            _countLab.text = [NSString stringWithFormat:@"%ld/%ld",(long)textView.text.length,(long)_maxCount];
//        }
    }
    
//    if(_style == _InputBarStyleDefault)
    {
        CGFloat height = [self string:textView.text heightWithFont:textView.font constrainedToWidth:textView.bounds.size.width] + 2*kStyleDefault_TBSpace;
        CGFloat heightDefault = kStyleDefault_Height;
        if(height >= heightDefault){
            [UIView animateWithDuration:0.3 animations:^{
                //调整frame
                CGRect frame = self.showFrameDefault;
                frame.size.height = height;
                frame.origin.y = _showFrameDefault.origin.y - (height - _showFrameDefault.size.height);
                self.frame = frame;
                
                //调整sendButton frame
                _sendButton.frame = CGRectMake(kScreenW - kStyleDefault_LRSpace - _sendButton.frame.size.width, self.bounds.size.height - _sendButton.bounds.size.height - kStyleDefault_TBSpace, _sendButton.bounds.size.width, _sendButton.bounds.size.height);
                
                //调整textView frame
                textView.frame = CGRectMake(kStyleDefault_LRSpace, kStyleDefault_TBSpace, textView.bounds.size.width, self.bounds.size.height - 2*kStyleDefault_TBSpace);
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                [self resetFrameDefault];
            }];
        }
    }
    
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 当键盘处于弹起状态，则收起来；否则，不接收事件
    if (self.textView.isFirstResponder) {
        if ([self.delegate respondsToSelector:@selector(onClickedOutside:)]) {
            [self.delegate onClickedOutside:self];
        }
        
        // 收起键盘
        [self.textView resignFirstResponder];
        
        return YES;
    }
    
    return NO;
}

#pragma mark - Action

- (void)onBackgroundClick:(UITapGestureRecognizer *)sender {
    if (self.style == _InputBarStyleDefault) {
    
        [self hide];
    } else {
        [self pinToBottom];
        
        if(self.textView.isFirstResponder) {
            [self.textView resignFirstResponder];
        }
    }
}

- (void)onSend:(UIButton *)button {
    
    if (self.sendBlock) {
        BOOL hideKeyBoard = self.sendBlock(self, self.textView.text);
        
        if (hideKeyBoard) {
            [self.textView resignFirstResponder];
            
            // 停留模式：发送后，回到底部
            if (self.style == _InputBarStyleStill) {
                [self pinToBottom];
            }
        }
    }
}

#pragma mark - 监听键盘

- (void)keyboardWillAppear:(NSNotification *)noti {
    
    if(_textView.isFirstResponder) {
        NSDictionary *info = [noti userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
        keyboardAnimationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        CGSize keyboardSize = [value CGRectValue].size;
        
        [UIView animateWithDuration:keyboardAnimationDuration animations:^{
            CGRect frame = self.frame;
            frame.origin.y = SuperViewHeight - keyboardSize.height - frame.size.height;
            self.frame = frame;
            
            self.showFrameDefault = self.frame;
        }];
    }
}

- (void)keyboardWillDisappear:(NSNotification *)noti {
    
    // 用户手动调用隐藏方法
    if (self.willHide) {
        [self animateHide];
        
        return;
    }
    
    // 普通模式、输入框获取了焦点
    if (self.textView.isFirstResponder) {
        
        if (self.style == _InputBarStyleDefault) {
            [self animateHide];
        } else if (self.style == _InputBarStyleStill) {
            [self pinToBottom];
        }
    }
}

#pragma mark - Setter & Getter

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
}

- (void)setTextViewBackgroundColor:(UIColor *)textViewBackgroundColor {
    _textViewBackgroundColor = textViewBackgroundColor;
    self.textBackgroundView.backgroundColor = textViewBackgroundColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _textView.font = font;
    self.placeholderLabel.font = _textView.font;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    
    // 规则：只要设置占位字符，就清空输入框
    [self clear];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setSendButtonBackgroundColor:(UIColor *)sendButtonBackgroundColor {
    _sendButtonBackgroundColor = sendButtonBackgroundColor;
    
    self.sendButton.backgroundColor = sendButtonBackgroundColor;
}

- (void)setSendButtonTitle:(NSString *)sendButtonTitle {
    _sendButtonTitle = sendButtonTitle;
    
    [self.sendButton setTitle:sendButtonTitle forState:UIControlStateNormal];
}

- (void)setSendButtonCornerRadius:(CGFloat)sendButtonCornerRadius {
    _sendButtonCornerRadius = sendButtonCornerRadius;
    
    self.sendButton.layer.cornerRadius = sendButtonCornerRadius;
}

- (void)setSendButtonFont:(UIFont *)sendButtonFont {
    _sendButtonFont = sendButtonFont;
    
    self.sendButton.titleLabel.font = sendButtonFont;
}

- (UIView *)backgroundView {
    if(!_backgroundView){
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor clearColor];
        
        [self setBackgroundTapRecogenizer:_backgroundView];
    }
    return _backgroundView;
}

#pragma mark - Utility

- (void)pinToBottom {
    CGRect frame = self.frame;
    frame.origin.y = SuperViewHeight - self.frame.size.height;
    self.frame = frame;
}

- (void)animateShow {
    [UIView animateWithDuration:keyboardAnimationDuration animations:^{
//        self.frame = self.showFrameDefault;
//        self.sendButton.frame = _sendButtonFrameDefault;
//        self.textView.frame =_textViewFrameDefault;
        
        [self pinToBottom];
    } completion:nil];
}

- (void)animateHide {
    [UIView animateWithDuration:keyboardAnimationDuration animations:^{
        CGRect frame = self.frame;
        frame.origin.y = SuperViewHeight;
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (self.style == _InputBarStyleDefault) {
            [self.backgroundView removeFromSuperview];
        }
        
        [self removeFromSuperview];
    }];
}

- (CGFloat)string:(NSString *)string heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize textSize;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:(NSStringDrawingUsesLineFragmentOrigin |
                                                 NSStringDrawingTruncatesLastVisibleLine)
                                     attributes:attributes
                                        context:nil].size;
    } else {
        textSize = [string sizeWithFont:textFont
                      constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                          lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:(NSStringDrawingUsesLineFragmentOrigin |
                                             NSStringDrawingTruncatesLastVisibleLine)
                                 attributes:attributes
                                    context:nil].size;
#endif
    
    return ceil(textSize.height);    
}

@end
