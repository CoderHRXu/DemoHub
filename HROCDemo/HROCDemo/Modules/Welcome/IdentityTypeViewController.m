//
//  IdentityTypeViewController.m
//  HROCDemo
//
//  Created by Jeremy on 2017/8/15.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "IdentityTypeViewController.h"
#import "IdentityTypeButton.h"

@interface IdentityTypeViewController ()

@property (weak, nonatomic) IBOutlet IdentityTypeButton *leftButton;
@property (weak, nonatomic) IBOutlet IdentityTypeButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *orLabel;
@property (weak, nonatomic) IBOutlet IdentityTypeButton *centerButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, assign) NSInteger appType;
@end

@implementation IdentityTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    self.appType = DDTUserTypeManager;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAppInfo];
}

- (void)initView {
    
    self.leftButton.centerImageView.image = [UIImage imageNamed:@"welcome_bborrower"];
    self.rightButton.centerImageView.image = [UIImage imageNamed:@"welcome_manager"];
    self.centerButton.centerImageView.image = [UIImage imageNamed:@"welcome_manager"];

    [self.leftButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getAppInfo {
    
#if PRO
    
    if (CacheHandlerInstance.currentSetting.isPreVersion) {
        
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
        self.orLabel.hidden = YES;
        self.centerButton.hidden = NO;

    } else {
        
        self.leftButton.hidden = NO;
        self.rightButton.hidden = NO;
        self.orLabel.hidden = NO;
        self.centerButton.hidden = YES;
    }
#else
    
    self.leftButton.hidden = NO;
    self.rightButton.hidden = NO;
    self.orLabel.hidden = NO;
    self.centerButton.hidden = YES;
#endif
}

- (void)selectButtonAction:(UIButton *)sender {
    
    if (sender == self.leftButton) {
        
        self.appType = DDTUserTypeBorrower;
        self.leftButton.selected = YES;
        self.rightButton.selected = NO;
        
    } else if (sender == self.rightButton) {
        
        self.appType = DDTUserTypeManager;
        self.leftButton.selected = NO;
        self.rightButton.selected = YES;
        
    } else if (sender == self.centerButton) {
        
        self.appType = DDTUserTypeManager;
        self.centerButton.selected = YES;
    }
}

- (void)submitAction {
    
    if ([self.delegate respondsToSelector:@selector(loadPageWithAppType:)]) {
        
        [self.delegate loadPageWithAppType:self.appType];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
