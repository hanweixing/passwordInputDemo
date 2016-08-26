//
//  ViewController.m
//  PasswordInputProject
//
//  Created by 韩卫星 on 16/8/26.
//  Copyright © 2016年 hanweixing. All rights reserved.
//

#import "ViewController.h"

#import <IQKeyboardManager.h>
#import "WKBalanceTurnOutInputPwdView.h"
#import "MBProgressHUD+H.h"

@interface ViewController ()

// 提现输入框
@property (strong, nonatomic) IBOutlet UITextField *withDrawTxtField;
// 输入框的透明背景视图
@property (strong, nonatomic) UIView *inputBackgroundView;
// 密码输入视图
@property (strong, nonatomic) WKBalanceTurnOutInputPwdView *inputWithDrawPwdView;

@end

@implementation ViewController

#pragma mark - 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  使用IQKeyboard管理键盘
     */
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
}

#pragma mark - 视图创建
/**
 *  输入视图的背景视图
 *
 */
- (UIView *)inputBackgroundView{
    if(_inputBackgroundView == nil){
        _inputBackgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
        _inputBackgroundView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_inputBackgroundView];
    }
    return _inputBackgroundView;
}

/**
 *  输入提现密码视图（懒加载）
 *
 */
- (WKBalanceTurnOutInputPwdView *)inputWithDrawPwdView{
    if(_inputWithDrawPwdView == nil){
        _inputWithDrawPwdView = [WKBalanceTurnOutInputPwdView initXibFileWithDelegate:self];
        _inputWithDrawPwdView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame), CGRectGetWidth(self.view.frame), 400);
        // 弱引用，在block中进行引用
//        __weak typeof(self) wself = self;
        _inputWithDrawPwdView.ForgetPwdBlock = ^(UIButton *btn){// 忘记密码
            
        };
        [self.inputBackgroundView addSubview:_inputWithDrawPwdView];
    }
    return _inputWithDrawPwdView;
}

#pragma mark - 动作事件
/**
 *  提现按钮事件
 *
 */
- (IBAction)withDrawBtnClicked:(UIButton *)sender {
    if([self.withDrawTxtField.text isEqualToString:@""]){
        // 利用MBProgressHUD定制的定时显示方法
        [MBProgressHUD showMessage:@"请输入转出金额！" hideInterval:2];
        return;
    }else if([self.withDrawTxtField.text doubleValue] > 200){
        [MBProgressHUD showMessage:@"转出金额大于当前余额，请重新输入！" hideInterval:2];
        return;
    }
    [self.inputWithDrawPwdView withDrawMoney:self.withDrawTxtField.text];
    [self.inputWithDrawPwdView clearValue];
    [UIView animateWithDuration:0.2 animations:^{
        self.inputBackgroundView.hidden = NO;
        self.inputWithDrawPwdView.frame = CGRectMake(0, CGRectGetHeight(self.inputBackgroundView.frame) - 400, CGRectGetWidth(self.inputBackgroundView.frame), 400);
        [self.inputWithDrawPwdView makeFirstInputBecomeFirstResponder];
    }];
}

/**
 *  隐藏输入视图
 */
- (void)hideInputBackgroundViewAndInputView{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.inputWithDrawPwdView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame), CGRectGetWidth(self.view.frame), 400);
    }];
    self.inputBackgroundView.hidden = YES;
}

#pragma mark - 代理
// 输入框代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string isEqualToString:@""]){// 删除
        textField.text = string;
        [self.inputWithDrawPwdView moveBackDeleteResponder];
    }else{// 填写
        textField.text = string;
        [self.inputWithDrawPwdView moveFirstResponder];
    }
    if([self.inputWithDrawPwdView isSixthInputFinished]){
        // 密码输入完成，网络请求提现
        // 密码是
        NSString *cashPwd = [NSString stringWithFormat:@"%@%@%@%@%@%@", [self.inputWithDrawPwdView returnFirstInputViewValue], [self.inputWithDrawPwdView returnSecondInputViewValue], [self.inputWithDrawPwdView returnThirdInputViewValue], [self.inputWithDrawPwdView returnFourthInputViewValue], [self.inputWithDrawPwdView returnFifthInputViewValue], [self.inputWithDrawPwdView returnSixthInputViewValue]];
        NSLog(@"cashPwd is %@", cashPwd);
        
        [self hideInputBackgroundViewAndInputView];
        [MBProgressHUD showMessage:@"提现成功！" hideInterval:5];
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
