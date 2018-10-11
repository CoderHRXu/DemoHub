//
//  NeedToLoginViewController.m
//  HROCDemo
//
//  Created by Jeremy on 2016/11/24.
//  Copyright © 2016年 RJS. All rights reserved.
//

#import "NeedToLoginViewController.h"
@interface NeedToLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation NeedToLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 5.0;
    _loginBtn.backgroundColor = kGlobalTintColor;
    [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginAction {
    
    [self presentLoginViewController];
}

@end
