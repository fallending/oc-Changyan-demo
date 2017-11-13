//
//  ChangeyanDef.h
//  ChangyanDemo
//
//  Created by 7 on 13/11/2017.
//  Copyright © 2017 changyan-dev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChangyanSDK.h"

typedef enum : NSUInteger {
    ChangeyanErrorTypeSuccess = CYSuccess,
    ChangeyanErrorTypeParamError = CYParamsError,
    ChangeyanErrorTypeLoginError = CYLoginError,
    ChangeyanErrorTypeOtherError = CYOtherError
    
} ChangeyanErrorType;

#define ChangeyanPlatformName   @"platform.Changyan"

@interface ChangeyanDef : NSObject

@end
