//
//  ResetPasswdFirstStepViewController.m
//  XiangFa
//
//  Created by PandaApe on 14/03/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import "ResetPasswdFirstStepViewController.h"
#import "ResetPasswdSecondStepViewController.h"
// net
#import "SendVerificationCodeRequest.h"
#import "ResetPasswdFirstStepRequest.h"

@interface ResetPasswdFirstStepViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField    *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField    *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton       *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton       *nextStepButton;

@property (nonatomic, strong)NSTimer                *verificationCodeTimer;
@property (nonatomic, assign)NSInteger              timerCount;

@end

@implementation ResetPasswdFirstStepViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavigationBarWhite];
}

#pragma mark - UI
- (void)setupUI{
    
    
    self.title = @"找回密码";

    _nextStepButton.layer.masksToBounds = YES;
    _nextStepButton.layer.cornerRadius = 5.0;
    
    [_phoneNumTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_getCodeButton addTarget:self action:@selector(getVerificationCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [_nextStepButton addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];

    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    //tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

- (void)keyboardHide:(UITapGestureRecognizer*)tap {
    [self.view endEditing:YES];
}

#pragma mark - 定时器处理
- (void)timerAction {
    
    _timerCount--;
    [_getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒", (long)_timerCount] forState:UIControlStateNormal];
    if (_timerCount == 0) {
        [_getCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        _getCodeButton.enabled = YES;
        [_verificationCodeTimer invalidate];
    }
}

#pragma mark - 网络请求
/**
 获取验证码
 */
- (void)getVerificationCodeAction {
    
    if (_phoneNumTextField.text.length != 11) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入完整的手机号"];
        [_phoneNumTextField becomeFirstResponder];
        return;
    }
    
    SendVerificationCodeRequest *codeRequest = [[SendVerificationCodeRequest alloc]init];
    codeRequest.phone = _phoneNumTextField.text;
    codeRequest.triggerScene = @(3);
    
    [codeRequest mlStartWithCompletionBlockWithSuccess:^(SendVerificationCodeRequest *request) {
        
        [_codeTextField becomeFirstResponder];
        [_verificationCodeTimer invalidate];
        _verificationCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        _timerCount = 60;
        [_getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒", (long)_timerCount] forState:UIControlStateNormal];
        _getCodeButton.enabled = NO;
        
        
    } failure:^(__kindof BaseRequest *request) {
        
    }];
}


/**
 下一步
 */
- (void)nextStepAction {
    
    if (_phoneNumTextField.text.length < 11) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入手机号"];
        [_phoneNumTextField becomeFirstResponder];
        return;
    } else if (_codeTextField.text.length < 6) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入验证码"];
        [_codeTextField becomeFirstResponder];
        return;
    }

    ResetPasswdFirstStepRequest *confirmRequest = [[ResetPasswdFirstStepRequest alloc]init];
    confirmRequest.phone = _phoneNumTextField.text;
    confirmRequest.code = _codeTextField.text;

    [XFProgressHUD showNormalHUDfromView:self.view withString:nil];
    [confirmRequest mlStartWithCompletionBlockWithSuccess:^(ResetPasswdFirstStepRequest *request) {
        
        [XFProgressHUD hideHUDfromView:self.view];
        ResetPasswdSecondStepViewController *setPasswdViewController    = [[ResetPasswdSecondStepViewController alloc] init];
        setPasswdViewController.phoneNum                    = self.phoneNumTextField.text;
        setPasswdViewController.validationCode              = self.codeTextField.text;
        [self.navigationController pushViewController:setPasswdViewController animated:YES];
        
    } failure:^(__kindof BaseRequest *request) {
        
        [XFProgressHUD hideHUDfromView:self.view];
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == _phoneNumTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    } else if (textField == _codeTextField) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
