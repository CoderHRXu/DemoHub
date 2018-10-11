//
//  LoginViewController.m
//  XiangFa
//
//  Created by PandaApe on 14/03/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginIdentityTypeViewController.h"
#import "ResetPasswdFirstStepViewController.h"
#import "RegisterFirstStepViewController.h"
// net
#import "LoginRequest.h"


#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"


@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton       *closeButton;
@property (weak, nonatomic) IBOutlet UITextField    *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField    *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton       *loginButton;
@property (weak, nonatomic) IBOutlet UIButton       *showPassWordButton;
@property (weak, nonatomic) IBOutlet UIButton       *registerButton;
@property (weak, nonatomic) IBOutlet UIButton       *findPasswordButton;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, assign) NSInteger phoneLength;

@end

@implementation LoginViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 自定义方法
/**
 初始化UI
 */
- (void)setupUI {
    
    self.title = @"登录";
    self.phoneLength = 0;
    
    [self.closeButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5.0;
    [self.loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGSize titleSize = [@"登录中..." sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:self.loginButton.titleLabel.font.fontName size:self.loginButton.titleLabel.font.pointSize]}];
    CGFloat leftSpace = (self.loginButton.frame.size.width - titleSize.width) / 2 - 30;
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(leftSpace, 10, 20, 20)];
    [self.activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [self.loginButton addSubview:self.activityView];

    [self.userNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passWordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.showPassWordButton addTarget:self action:@selector(showPassWordActoin) forControlEvents:UIControlEventTouchUpInside];
    [self.findPasswordButton addTarget:self action:@selector(findPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *str       = @"还没有注册？现在就去免费注册";
    NSString *stringA   = @"免费注册";
    NSString *stringB   = @"还没有注册？现在就去";
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:kGlobalTintColor
                          range:NSMakeRange(stringB.length, stringA.length)];
    self.registerButton.titleLabel.attributedText = attributedStr;
    [self.registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissViewController {
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 登录请求
- (void)loginAction {
    
    if (_userNameTextField.text.length < 1) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入账号"];
        [_userNameTextField becomeFirstResponder];
        return;
    } else if (_passWordTextField.text.length < 1) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入密码"];
        [_passWordTextField becomeFirstResponder];
        return;
    }
    
    [self.view endEditing:YES];
    [self.view setUserInteractionEnabled:NO];
    [self.loginButton setEnabled:NO];
    [self.activityView startAnimating];
    
    LoginRequest *loginRequest = [[LoginRequest alloc] init];
    NSString *loginName = [self.userNameTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    loginRequest.loginName = loginName;
    loginRequest.password = self.passWordTextField.text;
    loginRequest.showHUD = YES;
    
    [loginRequest mlStartWithCompletionBlockWithSuccess:^(LoginRequest *request) {
        
        [self.view setUserInteractionEnabled:YES];
        [self.loginButton setEnabled:YES];
        [self.activityView stopAnimating];
//        self.userInfoVo = request.userInfoVo;
        [self finishLogin];
        
    } failure:^(__kindof BaseRequest *request) {
        
        [self.view setUserInteractionEnabled:YES];
        [self.loginButton setEnabled:YES];
        [self.activityView stopAnimating];
    }];
}

- (void)finishLogin {
    
   
}

#pragma mark - 按钮点击
- (void)showPassWordActoin {
    
    self.showPassWordButton.selected = !self.showPassWordButton.selected;
    self.passWordTextField.secureTextEntry = !self.passWordTextField.secureTextEntry;
}

- (void)registerAction {
    
    RegisterFirstStepViewController *vc = [[RegisterFirstStepViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)findPasswordAction {
   
    ResetPasswdFirstStepViewController *vc = [[ResetPasswdFirstStepViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == self.userNameTextField) {
        
        if (textField.text.length > self.phoneLength) {
            
            if (textField.text.length == 4 || textField.text.length == 9 ) {    //输入
                
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }
            if (textField.text.length >= 13 ) {                                 //输入完成
                
                textField.text = [textField.text substringToIndex:13];
            }
            self.phoneLength = textField.text.length;
            
        } else if (textField.text.length < self.phoneLength) {                  //删除
            
            if (textField.text.length == 4 || textField.text.length == 9) {
                
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            self.phoneLength = textField.text.length;
        }
    } else if (textField == self.passWordTextField) {
        
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    return [textField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}

@end
