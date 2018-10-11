//
//  ResetPasswdSecondStepViewController.m
//  XiangFa
//
//  Created by PandaApe on 14/03/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import "ResetPasswdSecondStepViewController.h"

// net
#import "ResetPasswdSecondStepRequest.h"

#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface ResetPasswdSecondStepViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField    *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton       *registerRightNowButton;
@property (weak, nonatomic) IBOutlet UIButton       *showPasswordButton;

@end

@implementation ResetPasswdSecondStepViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [array removeObjectAtIndex:1];
    self.navigationController.viewControllers = array;
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavigationBarWhite];
}

#pragma mark - UI
- (void)setupUI {
    
    self.title = @"找回密码";
    
    self.registerRightNowButton.layer.masksToBounds = YES;
    self.registerRightNowButton.layer.cornerRadius = 5.0;
    [self.registerRightNowButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_showPasswordButton addTarget:self action:@selector(showPasswordActoin) forControlEvents:UIControlEventTouchUpInside];
    [_registerRightNowButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    //tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)keyboardHide:(UITapGestureRecognizer*)tap {
    [self.view endEditing:YES];
}

- (BOOL)navigationShouldPopOnBackButton {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    return NO;
}


#pragma mark - 网络请求
- (void)confirmAction {
    
    if (_passwordTextField.text.length < 1) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入密码"];
        [_passwordTextField becomeFirstResponder];
        return;
    } else if (_passwordTextField.text.length < 6) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"密码不符合规则"];
        [_passwordTextField becomeFirstResponder];
        return;
    }
    
    [self sendResetPasswdRequest];
}

- (void)sendResetPasswdRequest {
    
    ResetPasswdSecondStepRequest *restPasswordRequest   = [[ResetPasswdSecondStepRequest alloc]init];
    restPasswordRequest.phone                           = self.phoneNum;
    restPasswordRequest.newpassword                     = self.passwordTextField.text;
    restPasswordRequest.validationCode                  = self.validationCode;
    
    [XFProgressHUD showNormalHUDfromWindow:nil];
    
    [restPasswordRequest mlStartWithCompletionBlockWithSuccess:^(ResetPasswdSecondStepRequest *request) {
        
        [XFProgressHUD hideHUDfromWindow];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(__kindof ResetPasswdSecondStepRequest *request) {
        
        [XFProgressHUD hideHUDfromWindow];
    }];
    
}

#pragma mark - 按钮事件
- (void)showPasswordActoin {
    
    _showPasswordButton.selected = !_showPasswordButton.selected;
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == _passwordTextField) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}
@end
