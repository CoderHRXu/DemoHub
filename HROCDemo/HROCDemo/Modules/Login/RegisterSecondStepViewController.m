//
//  RegisterSecondStepViewController.m
//  HROCDemo
//
//  Created by Jeremy on 2017/8/29.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "RegisterSecondStepViewController.h"

#import "SendVerificationCodeRequest.h"
#import "RegisterRequest.h"

@interface RegisterSecondStepViewController ()
@property (weak, nonatomic) IBOutlet UITextField    *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField    *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton       *showPasswordButton;
@property (weak, nonatomic) IBOutlet UITextField    *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton       *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton       *registerButton;
@property (weak, nonatomic) IBOutlet UIButton       *protocolButton;

@property (nonatomic, strong) NSTimer               *verificationCodeTimer;
@property (nonatomic, assign) NSInteger             timerCount;
@end

@implementation RegisterSecondStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavigationBarWhite];
}

- (void)setupUI {
    
    self.title = @"注册";
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 5.0;

    [self.phoneNumTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.showPasswordButton addTarget:self action:@selector(showPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.getCodeButton addTarget:self action:@selector(getVerificationCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.protocolButton addTarget:self action:@selector(protocolButtonAction) forControlEvents:UIControlEventTouchUpInside];

    NSString *str       = @"点击注册表示同意《纳鑫金管家用户协议》";
    NSString *stringA   = @"点击注册表示同意";
    NSString *stringB   = @"《纳鑫金管家用户协议》";
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:kGlobalTintColor
                          range:NSMakeRange(stringA.length, stringB.length)];
    self.protocolButton.titleLabel.attributedText = attributedStr;
    [self.protocolButton addTarget:self action:@selector(protocolButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - 网络请求
/**
 获取验证码
 */
- (void)getVerificationCodeAction {
    
    if (![self.phoneNumTextField.text isMobileNumber]) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入正确格式的手机号"];
        [self.phoneNumTextField becomeFirstResponder];
        return;
    }
    
    SendVerificationCodeRequest *codeRequest = [[SendVerificationCodeRequest alloc]init];
    codeRequest.phone = _phoneNumTextField.text;
    codeRequest.triggerScene = @(1);
    
    [codeRequest mlStartWithCompletionBlockWithSuccess:^(SendVerificationCodeRequest *request) {
        
        [self.codeTextField becomeFirstResponder];
        [self.verificationCodeTimer invalidate];
        self.verificationCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        self.timerCount = 60;
        [self.getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒", (long)_timerCount] forState:UIControlStateNormal];
        self.getCodeButton.enabled = NO;
        
    } failure:^(__kindof BaseRequest *request) {
        
    }];
}

- (void)registerButtonAction {
    
    [self.view endEditing:YES];
    
    if (!self.phoneNumTextField.text.length) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入手机号"];
        [self.phoneNumTextField becomeFirstResponder];
        return;
    } else if (![self.phoneNumTextField.text isMobileNumber]) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入正确格式的手机号"];
        [self.phoneNumTextField becomeFirstResponder];
        return;
    }

    if (!self.passwordTextField.text.length) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入密码"];
        [self.passwordTextField becomeFirstResponder];
        return;
    } else if (_passwordTextField.text.length < 6) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"密码不符合规则"];
        [self.passwordTextField becomeFirstResponder];
        return;
    }

    if (self.codeTextField.text.length < 6) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入验证码"];
        [self.codeTextField becomeFirstResponder];
        return;
    }

    [XFProgressHUD showNormalHUDfromView:self.view withString:nil];
    
    RegisterRequest *regRequest = [[RegisterRequest alloc] init];
    regRequest.phone            = self.phoneNumTextField.text;
    regRequest.password         = self.passwordTextField.text;
    regRequest.code             = self.codeTextField.text;
    regRequest.userType         = self.userType;
    regRequest.invitationCode   = self.invitationCode;
    [regRequest mlStartWithCompletionBlockWithSuccess:^(RegisterRequest *request) {
        
        [XFProgressHUD hideHUDfromView:self.view];
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"注册成功！"];
      
        [NotificationManager postWithName:XFUserStatusChanged object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
      
    } failure:^(__kindof BaseRequest *request) {
       
        [XFProgressHUD hideHUDfromView:self.view];
    }];
}

- (void)showPasswordAction {
    
    self.showPasswordButton.selected = !_showPasswordButton.selected;
    self.passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
}

- (void)protocolButtonAction {
    
    [self.view endEditing:YES];
  
}

- (void)keyboardHide:(UITapGestureRecognizer*)tap {
    [self.view endEditing:YES];
}

#pragma mark - 定时器处理
- (void)timerAction {
    
    self.timerCount -= 1;
    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.timerCount] forState:UIControlStateNormal];
    if (self.timerCount == 0) {
        [self.getCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        self.getCodeButton.enabled = YES;
        [self.verificationCodeTimer invalidate];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == self.phoneNumTextField) {
        
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    } else if (textField == self.codeTextField) {
        
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    } else if (textField == self.passwordTextField) {
        
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
