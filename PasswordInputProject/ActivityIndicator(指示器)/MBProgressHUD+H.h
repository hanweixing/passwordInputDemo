//
//  MBProgressHUD+YG.h
//
//  Created by YG on 14-4-18.
//  Copyright (c) 2014年. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (YG)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showMessage:(NSString *)message toView:(UIView *)view method:(SEL)method onTarget:(id)target;

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

+ (MBProgressHUD *)showMessage:(NSString *)message  hideInterval:(CGFloat)time;

@end
