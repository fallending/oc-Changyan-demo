#import "_InputBar.h"
#import "_TextView.h"

#pragma mark - String length

@interface NSString ( Lengthness )

/** 'a' 长度 1；'我' 长度 1；'😄' 长度 2；*/
@property (nonatomic, assign, readonly) int32_t lengthAsUsual; // return NSString.length
/** 'a' 长度 1；'我' 长度 3；'😄' 长度 4； */
@property (nonatomic, assign, readonly) int32_t lengthAsUtf8;
/** 'a' 长度 2；'我' 长度 2；'😄' 长度 4； */
@property (nonatomic, assign, readonly) int32_t lengthAsUnicode; // lengthAsUsual x 2
/** 'ab' 长度 1；'我' 长度 1；'😄' 长度 1； */
@property (nonatomic, assign, readonly) int32_t lengthAsChis;
/** 'a' 长度 1；'我' 长度 2；'😄' 长度 4； */
@property (nonatomic, assign, readonly) int32_t lengthAsGbk;
/** 'a' 长度 1；'我' 长度 1；'😄' 长度 1；( Not sure! GOON dig! )*/
@property (nonatomic, assign, readonly) int32_t lengthAsPerfect;

/**
 Swift
 
 https://developer.apple.com/documentation/swift/string
 
 Measuring the Length of a String
 
 let flag = "🇵🇷"
 print(flag.count)
 // Prints "1"
 print(flag.unicodeScalars.count)
 // Prints "2"
 print(flag.utf16.count)
 // Prints "4"
 print(flag.utf8.count)
 // Prints "8"
 
 */

@end

#pragma mark - _InputBar

#define kScreenW    [UIScreen mainScreen].bounds.size.width
#define kScreenH    [UIScreen mainScreen].bounds.size.height

#define kStyleHorizontalSpace 10
#define kStyleInnerHorizontalSpace 5
#define kStyleVerticalSpace 8

#define kTextViewCornerRadius 4.f
#define kTextViewHolderBackgroundColor [UIColor colorWithRed:250/255.f green:250/255.f blue:250/255.f alpha:1.0]

#define kInputBarBorderColor [UIColor colorWithRed:191/255.f green:191/255.f blue:191/255.f alpha:1]
#define kInputTextViewBorderColor [UIColor colorWithRed:235/255.f green:235/255.f blue:235/255.f alpha:1]
#define kInputTextViewBackgroundColor [UIColor colorWithRed:252/255.f green:252/255.f blue:252/255.f alpha:1]

#define kSendButtonNormalTitleColor [UIColor colorWithRed:90/255.f green:90/255.f blue:90/255.f alpha:1]
#define kSendButtonDisableTitleColor [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1]

#define kInputBarHeight         50
#define kTextViewHeight         (kInputBarHeight-2*kStyleVerticalSpace)
#define kSendButtonHeight       (kInputBarHeight-2*kStyleVerticalSpace)
#define kSendButtonWidth        45

static CGFloat keyboardAnimationDuration = 0.3;
CGFloat SuperViewHeight = 0.f;

@interface _InputBar() <UITextViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) _InputBarStyle style;

@property (nonatomic, assign) id<_InputBarDelagete> delegate;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) _TextView *textView;
@property (nonatomic, strong) UIView *textBackgroundTopBorderView;

@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, assign) CGRect showFrameDefault;
@property (nonatomic, assign) CGRect sendButtonFrameDefault;
@property (nonatomic, assign) CGRect textViewFrameDefault;

@property (nonatomic, assign) BOOL willHide; // 将要隐藏标志

@property (nonatomic, weak) UIView *viewWithTapRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

///////////////////////////////////////////////////////
// InputBar 因为需要高内聚，很多细碎的功能挤在一个文件中，不得已，
// 拆出了一些 'Event' 的 'Handler' 来装额外的 'Action'。
///////////////////////////////////////////////////////
- (void)_onInit;
- (void)_onUnit;

- (void)_onKeyboardAppear;
- (void)_onKeyboardDisappear;

- (void)_onTextShow;
- (void)_onTextDismiss;
///////////////////////////////////////////////////////

@end

@implementation _InputBar

#pragma mark - 公有方法

+ (instancetype)showWithStyle:(_InputBarStyle)style delegate:(id<_InputBarDelagete>)delegate {
    SuperViewHeight = kScreenH;
    
    _InputBar *inputBar = [[_InputBar alloc] initWithStyle:style];
    inputBar.delegate = delegate;
    if ([inputBar.delegate respondsToSelector:@selector(onConfig:)]) {
        [inputBar.delegate onConfig:inputBar];
    }
    [inputBar setBackgroundTapRecogenizer:inputBar.backgroundView];
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:inputBar.backgroundView];
    [window addSubview:inputBar];
    
    [inputBar show:YES];
    
    return inputBar;
}

+ (instancetype)showWithStyle:(_InputBarStyle)style delegate:(id<_InputBarDelagete>)delegate inView:(UIView *)view {
    SuperViewHeight = view.frame.size.height;
    
    _InputBar *inputBar = [[_InputBar alloc] initWithStyle:style];
    inputBar.delegate = delegate;
    if ([inputBar.delegate respondsToSelector:@selector(onConfig:)]) {
        [inputBar.delegate onConfig:inputBar];
    }
    [inputBar setBackgroundTapRecogenizer:view];
    
    [view addSubview:inputBar];
    [view bringSubviewToFront:inputBar];
    
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

- (void)toggleFirstResponder:(BOOL)toFirstResponder {
    if (toFirstResponder) {
        [self.textView becomeFirstResponder];
    } else {
        [self.textView resignFirstResponder];
    }
}

- (void)clear {
    self.textView.text = nil;
    
    [self textViewDidChange:self.textView];
}

#pragma mark - Life cycle

- (void)initUI {
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame =
    CGRectMake(
               kScreenW - kStyleHorizontalSpace - kSendButtonWidth,
               kStyleVerticalSpace,
               kSendButtonWidth,
               kSendButtonHeight
               );
    [self.sendButton setTitleColor:kSendButtonNormalTitleColor forState:UIControlStateNormal];
    [self.sendButton setTitleColor:kSendButtonDisableTitleColor forState:UIControlStateDisabled];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(onSend_FixMultiClick) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.sendButton];
    
    self.textView = [[_TextView alloc] initWithFrame:
                     CGRectMake(
                                kStyleHorizontalSpace,
                                kStyleVerticalSpace,
                                kScreenW - 2*kStyleHorizontalSpace,
                                kTextViewHeight
                                )];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.backgroundColor = kInputTextViewBackgroundColor;
    self.textView.delegate = self;
    self.textView.layer.borderColor = kInputTextViewBorderColor.CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = kTextViewCornerRadius;
    [self addSubview:self.textView];
    
    { // 上边框
        self.textBackgroundTopBorderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0.5)];
        self.textBackgroundTopBorderView.backgroundColor = kInputBarBorderColor;
        [self addSubview:self.textBackgroundTopBorderView];
    }
}

- (void)initNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)uinitNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithStyle:(_InputBarStyle)style {
    self = [super init];
    if (self) {
        self.style = style;
        self.backgroundColor = kTextViewHolderBackgroundColor;
        self.frame = CGRectMake(0, kScreenH, kScreenW, kInputBarHeight);;
        
        [self initUI];
        
        [self _onInit];
    }
    return self;
}

- (void)dealloc {
    [self _onUnit];
}

#pragma mark - 私有方法

- (void)show:(BOOL)becomeFirstResponder {
    if([self.delegate respondsToSelector:@selector(willShow:)]){
        [self.delegate willShow:self];
    }
    
    _textView.text = nil;

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
    return @(kInputBarHeight);
}

- (void)resetFrameDefault {
    self.frame = self.showFrameDefault;
    self.sendButton.frame = self.sendButtonFrameDefault;
    self.textView.frame = self.textViewFrameDefault;
}

- (void)setBackgroundTapRecogenizer:(UIView *)view {
    if (!view) {
        
        if (self.viewWithTapRecognizer &&
            self.tapRecognizer) {
            [self.viewWithTapRecognizer removeGestureRecognizer:self.tapRecognizer];
            
            self.viewWithTapRecognizer = nil;
            self.tapRecognizer = nil;
        }
        
        return;
    }
    
    view.userInteractionEnabled = YES;
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundClick:)];
    self.tapRecognizer.delegate = self;
    [view addGestureRecognizer:self.tapRecognizer];
    
    self.viewWithTapRecognizer = view;
    
    NSLog(@"IN, view = %@, tap = %@", self.viewWithTapRecognizer, self.tapRecognizer);
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if(textView.text.length) {

        // 将发送按钮置为有效
        self.sendButton.enabled = YES;
        
        ////////////////////////////////////////////////
        
        [self _onTextShow];
        
        ////////////////////////////////////////////////
    } else {

        // 将发送按钮置为无效
        self.sendButton.enabled = NO;
        
        ////////////////////////////////////////////////
        
        [self _onTextDismiss];
        
        ////////////////////////////////////////////////
    }
    
    // TODO：字符数控制
    if(_maxCount > 0) {
        if (textView.text.length > _maxCount) {
            textView.text = [textView.text substringToIndex:_maxCount];
            
            // 发送通知
            if ([self.delegate respondsToSelector:@selector(onMacCountTriggerred:text:)]) {
                [self.delegate onMacCountTriggerred:self text:textView.text];
            }
        }
    }
    
    {
        CGFloat height = [self string:textView.text heightWithFont:textView.font constrainedToWidth:textView.bounds.size.width] + 2*kStyleVerticalSpace;
        CGFloat heightDefault = kInputBarHeight;
        if(height >= heightDefault) {
            [UIView animateWithDuration:0.3 animations:^{
                //调整frame
                CGRect frame = self.showFrameDefault;
                frame.size.height = height;
                frame.origin.y = _showFrameDefault.origin.y - (height - _showFrameDefault.size.height);
                self.frame = frame;
                
                //调整sendButton frame
                _sendButton.frame = CGRectMake(kScreenW - kStyleHorizontalSpace - _sendButton.frame.size.width, self.bounds.size.height - _sendButton.bounds.size.height - kStyleVerticalSpace, _sendButton.bounds.size.width, _sendButton.bounds.size.height);
                
                //调整textView frame
                textView.frame = CGRectMake(
                                            kStyleHorizontalSpace,
                                            kStyleVerticalSpace,
                                            textView.bounds.size.width,
                                            self.bounds.size.height - 2*kStyleVerticalSpace
                                            );
            }];
        }
//        else {
//            [UIView animateWithDuration:0.3 animations:^{
//                [self resetFrameDefault];
//            }];
//        }
    }
    
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 如果点击touch在SendButton中，则不处理；显示在UIWindow的时候，不需要处理这个情况。
    CGPoint point = [touch locationInView:gestureRecognizer.view];
    CGPoint pointInExpect = [gestureRecognizer.view convertPoint:point toView:self];
    if (self.style == _InputBarStyleStill
        &&
        !self.sendButton.hidden
        &&
        CGRectContainsPoint(self.sendButton.frame, pointInExpect)) {
        return NO;
    }
    
    if (self.style == _InputBarStyleStill
        &&
        CGRectContainsPoint(self.textView.frame, pointInExpect)) {
        return NO;
    }

    // 当键盘处于弹起状态，则收起来；否则，不接收事件
    if (self.textView.isFirstResponder) {
        if ([self.delegate respondsToSelector:@selector(onBackground:)]) {
            [self.delegate onBackground:self];
        }
        
        // 收起键盘
        [self.textView resignFirstResponder];
        
        return YES;
    } else {
        
    }
    
    return NO;
}

#pragma mark - 点击事件处理

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

- (void)onSend {
    if ([self.delegate respondsToSelector:@selector(onSend:text:)]) {
        BOOL hideKeyBoard = [self.delegate onSend:self text:self.textView.text];
        
        if (hideKeyBoard) {
            [self.textView resignFirstResponder];
            
            // 停留模式：发送后，回到底部
            if (self.style == _InputBarStyleStill) {
                [self pinToBottom];
            }
        }
    }
}

- (void)onSend_FixMultiClick {
    
    NSLog(@"onsend");
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(onSend) object:nil];
    
    [self performSelector:@selector(onSend) withObject:nil afterDelay:0.3];
}

#pragma mark - 内部事件构建与处理

- (void)_onInit {
    self.showFrameDefault = self.frame;
    self.sendButtonFrameDefault = self.sendButton.frame;
    self.textViewFrameDefault = self.textView.frame;
    
    self.sendButton.hidden = YES;
    self.sendButton.enabled = NO;
    
    [self initNotification];
}

- (void)_onUnit {
    [self uinitNotification];
    
    [self setBackgroundTapRecogenizer:nil];
}

- (void)_onKeyboardAppear {
    if (self.sendButton.hidden) { // 如果当前 是 隐藏态
        
//        [UIView animateWithDuration:0.3 animations:^{
            self.textView.frame =
            CGRectMake(
                       kStyleHorizontalSpace,
                       kStyleVerticalSpace,
                       kScreenW - 3*kStyleHorizontalSpace - kSendButtonWidth,
                       self.bounds.size.height-2*kStyleVerticalSpace
                       );
            
            self.sendButton.hidden = NO;
//        }];
        
    }
}

- (void)_onKeyboardDisappear {
    if (!self.sendButton.hidden // 如果当前 是 显示态
        && !self.textView.text.length
        ) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.textView.frame =
            CGRectMake(
                       kStyleHorizontalSpace,
                       kStyleVerticalSpace,
                       kScreenW - 2*kStyleHorizontalSpace,
                       self.bounds.size.height-2*kStyleVerticalSpace);
            
            self.sendButton.hidden = YES;
        }];
        
    }
}

- (void)_onTextShow {
    if (self.sendButton.hidden) {

        self.textView.frame =
        CGRectMake(
                   kStyleHorizontalSpace,
                   kStyleVerticalSpace,
                   kScreenW - 3*kStyleHorizontalSpace - kSendButtonWidth,
                   self.bounds.size.height-2*kStyleVerticalSpace
                   );

        self.sendButton.hidden = NO;
        
    }
}

- (void)_onTextDismiss {
    if (self.textView.isFirstResponder) { // 键盘弹起态
        self.sendButton.hidden = NO;
    } else { // 键盘收起态
        
        [UIView animateWithDuration:0.3 animations:^{
            self.textView.frame =
            CGRectMake(
                       kStyleHorizontalSpace,
                       kStyleVerticalSpace,
                       kScreenW - 2*kStyleHorizontalSpace,
                       self.bounds.size.height-2*kStyleVerticalSpace);
            
            self.sendButton.hidden = YES;
        }];
    }
}

#pragma mark - 监听键盘

- (void)keyboardWillAppear:(NSNotification *)noti {
    
    if(_textView.isFirstResponder) {
        NSDictionary *info = [noti userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
        keyboardAnimationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        CGSize keyboardSize = [value CGRectValue].size;
        
        // FIXME: 特殊处理：当在【停留模式】的时候，自定义背景视图的时候，在键盘弹出的时候，添加手势；在键盘收起的时候，移除手势。【冲突点】停留模式下，弹出系统Alert视图，Alert的按钮点击，会被背景视图的手势截获。
        if (self.style == _InputBarStyleStill &&
            _backgroundView) {
            [self setBackgroundTapRecogenizer:_backgroundView];
        }
        
        [UIView animateWithDuration:keyboardAnimationDuration animations:^{
            CGRect frame = self.frame;
            frame.origin.y = SuperViewHeight - keyboardSize.height - frame.size.height;
            self.frame = frame;
            
            self.showFrameDefault = self.frame;
        }];
        
        ////////////////////////////////////////////////
        
        [self _onKeyboardAppear];
        
        ////////////////////////////////////////////////
    }
}

- (void)keyboardWillDisappear:(NSNotification *)noti {
    
    ////////////////////////////////////////////////
    
    [self _onKeyboardDisappear];
    
    ////////////////////////////////////////////////
    
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
            
            // FIXME: 特殊处理：当在【停留模式】的时候，自定义背景视图的时候，在键盘弹出的时候，添加手势；在键盘收起的时候，移除手势。【冲突点】停留模式下，弹出系统Alert视图，Alert的按钮点击，会被背景视图的手势截获。
            if (_backgroundView) {
                [self setBackgroundTapRecogenizer:nil];
                
                _backgroundView.userInteractionEnabled = NO;
            }
        }
    }
}

#pragma mark - Setter & Getter

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
}

- (void)setTextViewBackgroundColor:(UIColor *)textViewBackgroundColor {
    _textViewBackgroundColor = textViewBackgroundColor;
//    self.textBackgroundView.backgroundColor = textViewBackgroundColor;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    self.textView.placeholder = placeholder;
    
    // 规则：只要设置占位字符，就清空输入框
    if (self.textView.text.length) {
        [self clear];
    }
}

- (UIView *)backgroundView {
    if(!_backgroundView){
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor clearColor];
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

#pragma mark -

@implementation NSString ( Lengthness )

- (int32_t)lengthAsUsual {
    return (int32_t)self.length;
}

- (int32_t)lengthAsUtf8 {
    return (int32_t)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
}

- (int32_t)lengthAsUnicode {
    return (int32_t)[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
}

- (int32_t)lengthAsChis {
    NSInteger length = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    length -= (length - self.length) / 2;
    length = (length +1) / 2;
    
    return (int32_t)length;
}

- (int32_t)lengthAsGbk {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [self dataUsingEncoding:enc];
    return (int32_t)[data length];
}

- (int32_t)lengthAsPerfect {
    __block NSInteger stringLength = 0;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          stringLength += 1;
                                      } else {
                                          stringLength += 1;
                                      }
                                  } else {
                                      stringLength += 1;
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      stringLength += 1;
                                  } else {
                                      stringLength += 1;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      stringLength += 1;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      stringLength += 1;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      stringLength += 1;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      stringLength += 1;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      stringLength += 1;
                                  } else {
                                      stringLength += 1;
                                  }
                              }
                          }];
    
    return (int32_t)stringLength;
}

/**
 
 iOS:
 https://github.com/GabrielMassana/SearchEmojiOnString-iOS
 
 Others:
 [iOS开发emoji处理方式大起底](http://blog.csdn.net/allanGold/article/details/51689350)
 [Emoji List - Based on iOS 10 and macOS 10.12](http://rodrigopolo.com/files/emojilist/)
 
 判断并禁止表情输入（取巧的办法）:
 if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
    return NO;
 }
 
 iOS表情编码集：
 
 NSString *s = @"This is a smiley /ue415 face";
 testFace.text = s;
 上面的/ue415就是表情编码。更多的表情如下：
 /ue415 /ue056 /ue057 /ue414 /ue405 /ue106 /ue418
 /ue417 /ue40d /ue40a /ue404 /ue105 /ue409 /ue40e
 /ue402 /ue108 /ue403 /ue058 /ue407 /ue401 /ue40f
 /ue40b /ue406 /ue413 /ue411 /ue412 /ue410 /ue107
 /ue059 /ue416 /ue408 /ue40c /ue11a /ue10c /ue32c
 /ue32a /ue32d /ue328 /ue32b /ue022 /ue023 /ue327
 /ue329 /ue32e /ue32f /ue335 /ue334 /ue021 /ue337
 /ue020 /ue336 /ue13c /ue330 /ue331 /ue326 /ue03e
 /ue11d /ue05a /ue00e /ue421 /ue420 /ue00d /ue010
 /ue011 /ue41e /ue012 /ue422 /ue22e /ue22f /ue231
 /ue230 /ue427 /ue41d /ue00f /ue41f /ue14c /ue201
 /ue115 /ue428 /ue51f /ue429 /ue424 /ue423 /ue253
 /ue426 /ue111 /ue425 /ue31e /ue31f /ue31d /ue001
 /ue002 /ue005 /ue004 /ue51a /ue519 /ue518 /ue515
 /ue516 /ue517 /ue51b /ue152 /ue04e /ue51c /ue51e
 /ue11c /ue536 /ue003 /ue41c /ue41b /ue419 /ue41a
 /ue04a /ue04b /ue049 /ue048 /ue04c /ue13d /ue443
 /ue43e /ue04f /ue052 /ue053 /ue524 /ue52c /ue52a
 /ue531 /ue050 /ue527 /ue051 /ue10b /ue52b /ue52f
 /ue528 /ue01a /ue134 /ue530 /ue529 /ue526 /ue52d
 /ue521 /ue523 /ue52e /ue055 /ue525 /ue10a /ue109
 /ue522 /ue019 /ue054 /ue520 /ue306 /ue030 /ue304
 /ue110 /ue032 /ue305 /ue303 /ue118 /ue447 /ue119
 /ue307 /ue308 /ue444 /ue441
 /ue436 /ue437 /ue438 /ue43a /ue439 /ue43b /ue117
 /ue440 /ue442 /ue446 /ue445 /ue11b /ue448 /ue033
 /ue112 /ue325 /ue312 /ue310 /ue126 /ue127 /ue008
 /ue03d /ue00c /ue12a /ue00a /ue00b /ue009 /ue316
 /ue129 /ue141 /ue142 /ue317 /ue128 /ue14b /ue211
 /ue114 /ue145 /ue144 /ue03f /ue313 /ue116 /ue10f
 /ue104 /ue103 /ue101 /ue102 /ue13f /ue140 /ue11f
 /ue12f /ue031 /ue30e /ue311 /ue113 /ue30f /ue13b
 /ue42b /ue42a /ue018 /ue016 /ue015 /ue014 /ue42c
 /ue42d /ue017 /ue013 /ue20e /ue20c /ue20f /ue20d
 /ue131 /ue12b /ue130 /ue12d /ue324 /ue301 /ue148
 /ue502 /ue03c /ue30a /ue042 /ue040 /ue041 /ue12c
 /ue007 /ue31a /ue13e /ue31b /ue006 /ue302 /ue319
 /ue321 /ue322 /ue314 /ue503 /ue10e /ue318 /ue43c
 /ue11e /ue323 /ue31c /ue034 /ue035 /ue045 /ue338
 /ue047 /ue30c /ue044 /ue30b /ue043 /ue120 /ue33b
 /ue33f /ue341 /ue34c /ue344 /ue342 /ue33d /ue33e
 /ue340 /ue34d /ue339 /ue147 /ue343 /ue33c /ue33a
 /ue43f /ue34b /ue046 /ue345 /ue346 /ue348 /ue347
 /ue34a /ue349
 /ue036 /ue157 /ue038 /ue153 /ue155 /ue14d /ue156
 /ue501 /ue158 /ue43d /ue037 /ue504 /ue44a /ue146
 /ue50a /ue505 /ue506 /ue122 /ue508 /ue509 /ue03b
 /ue04d /ue449 /ue44b /ue51d /ue44c /ue124 /ue121
 /ue433 /ue202 /ue135 /ue01c /ue01d /ue10d /ue136
 /ue42e /ue01b /ue15a /ue159 /ue432 /ue430 /ue431
 /ue42f /ue01e /ue039 /ue435 /ue01f /ue125 /ue03a
 /ue14e /ue252 /ue137 /ue209 /ue154 /ue133 /ue150
 /ue320 /ue123 /ue132 /ue143 /ue50b /ue514 /ue513
 /ue50c /ue50d /ue511 /ue50f /ue512 /ue510 /ue50e
 /ue21c /ue21d /ue21e /ue21f /ue220 /ue221 /ue222
 /ue223 /ue224 /ue225 /ue210 /ue232 /ue233 /ue235
 /ue234 /ue236 /ue237 /ue238 /ue239 /ue23b /ue23a
 /ue23d /ue23c /ue24d /ue212 /ue24c /ue213 /ue214
 /ue507 /ue203 /ue20b /ue22a /ue22b /ue226 /ue227
 /ue22c /ue22d /ue215 /ue216 /ue217 /ue218 /ue228
 /ue151 /ue138 /ue139 /ue13a /ue208 /ue14f /ue20a
 /ue434 /ue309 /ue315 /ue30d /ue207 /ue229 /ue206
 /ue205 /ue204 /ue12e /ue250 /ue251 /ue14a /ue149
 /ue23f /ue240 /ue241 /ue242 /ue243 /ue244 /ue245
 /ue246 /ue247 /ue248 /ue249 /ue24a /ue24b /ue23e
 /ue532 /ue533 /ue534 /ue535 /ue21a /ue219 /ue21b
 /ue02f /ue024 /ue025 /ue026 /ue027 /ue028 /ue029
 /ue02a /ue02b /ue02c /ue02d /ue02e /ue332 /ue333
 /ue24e /ue24f /ue537
 
 */

@end
