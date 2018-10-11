//
//  RegisterFirstStepViewController.m
//  XiangFa
//
//  Created by Jeremy on 2017/5/26.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "RegisterFirstStepViewController.h"
#import "RegisterSecondStepViewController.h"

@interface RegisterFirstStepViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView    *borrowerImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *borrowerCircleImageView;
@property (weak, nonatomic) IBOutlet UIButton       *leftButton;
@property (weak, nonatomic) IBOutlet UIImageView    *managerImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *managerCircleImageView;
@property (weak, nonatomic) IBOutlet UIButton       *rightButton;

@property (weak, nonatomic) IBOutlet UITextField    *recommendedPersonTextField;
@property (weak, nonatomic) IBOutlet UIButton       *nextStepButton;
@property (nonatomic, assign) DDTUserType userType;
@end

@implementation RegisterFirstStepViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setCenterView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavigationBarWhite];
}

#pragma mark - UI
- (void)setupUI {
    
    self.title = @"注册";
    self.nextStepButton.layer.masksToBounds = YES;
    self.nextStepButton.layer.cornerRadius = 5.0;
    [self.nextStepButton addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
    [self.recommendedPersonTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)setCenterView {
    
    self.userType = DDTUserTypeUndefined;
    [self.leftButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectButtonAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if (sender == self.leftButton) {
        
        [self.borrowerImageView setHighlighted:YES];
        [self.borrowerCircleImageView setHighlighted:YES];
        [self.managerImageView setHighlighted:NO];
        [self.managerCircleImageView setHighlighted:NO];
        self.userType = DDTUserTypeBorrower;
    } else {
        
        [self.borrowerImageView setHighlighted:NO];
        [self.borrowerCircleImageView setHighlighted:NO];
        [self.managerImageView setHighlighted:YES];
        [self.managerCircleImageView setHighlighted:YES];
        self.userType = DDTUserTypeManager;
    }
}

- (void)nextStepAction {
    
    if (self.userType == DDTUserTypeUndefined) {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请选择身份类型"];
        return;
    }
    
    NSString *recommendedPerson = self.recommendedPersonTextField.text;
    if (recommendedPerson.length > 0 && ![recommendedPerson isMobileNumber]) {
        
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请输入正确的推荐人手机号"];
        [self.recommendedPersonTextField becomeFirstResponder];
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功后，身份不可以修改" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        RegisterSecondStepViewController *vc    = [[RegisterSecondStepViewController alloc] init];
        vc.userType                             = self.userType;
        vc.invitationCode                       = self.recommendedPersonTextField.text;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)keyboardHide:(UITapGestureRecognizer*)tap {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == self.recommendedPersonTextField) {
        
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}
@end
