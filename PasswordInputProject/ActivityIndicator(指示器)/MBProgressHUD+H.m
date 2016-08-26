//
//  MBProgressHUD+YG.m
//
//  Created by YG on 14-4-18.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "MBProgressHUD+H.h"

@implementation MBProgressHUD (YG)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
    hud.square = NO;
    // 设置图片
    //    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    // 1秒之后再消失
//    [hud hide:YES afterDelay:5.0];
    [hud hideAnimated:YES afterDelay:5.0];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.color = [UIColor grayColor];
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    hud.detailsLabelText = message;
    hud.square = NO;
    //显示模式
    hud.mode = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    // 1秒之后再消失
    [hud hide:YES afterDelay:20.0];
    
    return hud;
}
+ (void)showMessage:(NSString *)message toView:(UIView *)view method:(SEL)method onTarget:(id)target
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.detailsLabelText = message;
    hud.dimBackground = YES;
    hud.animationType = MBProgressHUDAnimationZoomIn;
    // Regiser for HUD callbacks so we can remove it from the window at the right
    // time
    hud.delegate = target;

    // Show the HUD while the provided method executes in a new thread
    [hud showWhileExecuting:method
                   onTarget:target
                 withObject:nil
                   animated:YES];
}

+ (void)showSuccess:(NSString *)success
{
    if (success.length > 0) {
        [self showSuccess:success toView:nil];
    }
}

+ (void)showError:(NSString *)error
{
    if (error.length > 0) {
        [self showError:error toView:nil];
    }
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

#pragma mark 自定义时间隐藏
+ (MBProgressHUD *)showMessage:(NSString *)message  hideInterval:(CGFloat)time{
    return [self showMessage:message toView:nil hideInterval:time];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view hideInterval:(CGFloat)time
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.color = [UIColor grayColor];
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    hud.detailsLabelText = message;
    hud.square = NO;
    //显示模式
    hud.mode = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    // 1秒之后再消失
    [hud hide:YES afterDelay:time];
    
    return hud;
}
@end
