//
//  _TextView.h
//  ChangyanDemo
//
//  Created by 7 on 04/12/2017.
//  Copyright © 2017 changyan-dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _TextView : UITextView

/**
 Set textView's placeholder text. Default is nil.
 */
@property(nullable, nonatomic,copy) IBInspectable NSString    *placeholder;

@end
