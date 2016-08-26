//
//  WKBalanceTurnOutInputPwdView.m
//  WiKi_O2O_iOS_Store
//
//  Created by 韩卫星 on 16/8/17.
//  Copyright © 2016年 安徽圆周率网络科技有限公司. All rights reserved.
//

#import "WKBalanceTurnOutInputPwdView.h"

/**
 *  UIColor
 */
#define ColorFormRGB(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]
#define ColorFromRGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]//颜色转换（从16位转化为rgb）

@interface WKBalanceTurnOutInputPwdView ()

@property (strong, nonatomic) IBOutlet UILabel *withDrawTipLab;// 提现多少钱


@property (strong, nonatomic) IBOutlet UIView *whiteView;

@property (strong, nonatomic) IBOutlet UITextField *firstInputTxtField;
@property (strong, nonatomic) IBOutlet UITextField *secondInputTxtField;
@property (strong, nonatomic) IBOutlet UITextField *thirdInputTxtField;
@property (strong, nonatomic) IBOutlet UITextField *fourthInputTxtField;
@property (strong, nonatomic) IBOutlet UITextField *fifthInputTxtField;
@property (strong, nonatomic) IBOutlet UITextField *sixthInputTxtField;

@end

@implementation WKBalanceTurnOutInputPwdView

+ (instancetype)initXibFileWithDelegate:(id)target{
    WKBalanceTurnOutInputPwdView *inputView = [[[NSBundle mainBundle] loadNibNamed:@"WKBalanceTurnOutInputPwdView" owner:nil options:nil] firstObject];
    inputView.whiteView.layer.borderWidth = 1.0f;
    inputView.whiteView.layer.borderColor = UIColorFromRGBA(0x828282, 1).CGColor;
    inputView.firstInputTxtField.delegate = target;
    inputView.secondInputTxtField.delegate = target;
    inputView.thirdInputTxtField.delegate = target;
    inputView.fourthInputTxtField.delegate = target;
    inputView.fifthInputTxtField.delegate = target;
    inputView.sixthInputTxtField.delegate = target;
    return inputView;
}

- (void)withDrawMoney:(NSString *)money{
    self.withDrawTipLab.text = [NSString stringWithFormat:@"提现%.2f元", [money doubleValue]];
}

- (void)clearValue{
    self.firstInputTxtField.text = @"";
    self.secondInputTxtField.text = @"";
    self.thirdInputTxtField.text = @"";
    self.fourthInputTxtField.text = @"";
    self.fifthInputTxtField.text = @"";
    self.sixthInputTxtField.text = @"";
}

- (void)makeFirstInputBecomeFirstResponder{
    [self.firstInputTxtField becomeFirstResponder];
}

- (NSString *)returnFirstInputViewValue{
    return self.firstInputTxtField.text;
}

- (NSString *)returnSecondInputViewValue{
    return self.secondInputTxtField.text;
}

- (NSString *)returnThirdInputViewValue{
    return self.thirdInputTxtField.text;
}

- (NSString *)returnFourthInputViewValue{
    return self.fourthInputTxtField.text;
}

- (NSString *)returnFifthInputViewValue{
    return self.fifthInputTxtField.text;
}

- (NSString *)returnSixthInputViewValue{
    return self.sixthInputTxtField.text;
}

- (BOOL)isSixthInputFinished{
    if([self.firstInputTxtField.text isEqualToString:@""]){
        return NO;
    }else if([self.secondInputTxtField.text isEqualToString:@""]){
        return NO;
    }else if([self.thirdInputTxtField.text isEqualToString:@""]){
        return NO;
    }else if([self.fourthInputTxtField.text isEqualToString:@""]){
        return NO;
    }else if([self.fifthInputTxtField.text isEqualToString:@""]){
        return NO;
    }else if([self.sixthInputTxtField.text isEqualToString:@""]){
        return NO;
    }
    return YES;
}

- (void)moveFirstResponder{
    if([self.firstInputTxtField isFirstResponder]){
        [self.firstInputTxtField resignFirstResponder];
        [self.secondInputTxtField becomeFirstResponder];
    }else if([self.secondInputTxtField isFirstResponder]){
        [self.secondInputTxtField resignFirstResponder];
        [self.thirdInputTxtField becomeFirstResponder];
    }else if([self.thirdInputTxtField isFirstResponder]){
        [self.thirdInputTxtField resignFirstResponder];
        [self.fourthInputTxtField becomeFirstResponder];
    }else if([self.fourthInputTxtField isFirstResponder]){
        [self.fourthInputTxtField resignFirstResponder];
        [self.fifthInputTxtField becomeFirstResponder];
    }else if([self.fifthInputTxtField isFirstResponder]){
        [self.fifthInputTxtField resignFirstResponder];
        [self.sixthInputTxtField becomeFirstResponder];
    }
}

- (void)moveBackDeleteResponder{
    if([self.sixthInputTxtField isFirstResponder]){
        [self.sixthInputTxtField resignFirstResponder];
        [self.fifthInputTxtField becomeFirstResponder];
    }else if([self.fifthInputTxtField isFirstResponder]){
        [self.fifthInputTxtField resignFirstResponder];
        [self.fourthInputTxtField becomeFirstResponder];
    }else if([self.fourthInputTxtField isFirstResponder]){
        [self.fourthInputTxtField resignFirstResponder];
        [self.thirdInputTxtField becomeFirstResponder];
    }else if([self.thirdInputTxtField isFirstResponder]){
        [self.thirdInputTxtField resignFirstResponder];
        [self.secondInputTxtField becomeFirstResponder];
    }else if([self.secondInputTxtField isFirstResponder]){
        [self.secondInputTxtField resignFirstResponder];
        [self.firstInputTxtField becomeFirstResponder];
    }else if([self.firstInputTxtField isFirstResponder]){
        
    }
}

// 向左开始响应
- (IBAction)leftBackBtnClicked:(UIButton *)sender {
    if([self.firstInputTxtField isFirstResponder]){
        return;
    }else if([self.secondInputTxtField isFirstResponder]){
        [self.secondInputTxtField resignFirstResponder];
        [self.firstInputTxtField becomeFirstResponder];
    }else if([self.thirdInputTxtField isFirstResponder]){
        [self.thirdInputTxtField resignFirstResponder];
        [self.secondInputTxtField becomeFirstResponder];
    }else if([self.fourthInputTxtField isFirstResponder]){
        [self.fourthInputTxtField resignFirstResponder];
        [self.thirdInputTxtField becomeFirstResponder];
    }else if([self.fifthInputTxtField isFirstResponder]){
        [self.fifthInputTxtField resignFirstResponder];
        [self.fourthInputTxtField becomeFirstResponder];
    }else if([self.sixthInputTxtField isFirstResponder]){
        [self.sixthInputTxtField resignFirstResponder];
        [self.fifthInputTxtField becomeFirstResponder];
    }
}

// 忘记密码
- (IBAction)forgetPwdBtnClicked:(UIButton *)sender {
    if(self.ForgetPwdBlock){
        self.ForgetPwdBlock(sender);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
