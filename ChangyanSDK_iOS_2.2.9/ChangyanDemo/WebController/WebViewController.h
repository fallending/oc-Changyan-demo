//
//  WebViewController.h
//  ChangyanDemo
//
//  Created by 7 on 07/11/2017.
//  Copyright © 2017 changyan-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AEHybridEngine/AEHybridEngine.h>

@interface WebViewController : UIViewController

- (void)aesLogin:(id)body AE_JSHANDLED_SELECTOR(aesLogin);

- (void)aesShare:(id)body AE_JSHANDLED_SELECTOR(aesShare);

- (void)aesSetTitle:(id)body AE_JSHANDLED_SELECTOR(aesSetTitle);

@end

