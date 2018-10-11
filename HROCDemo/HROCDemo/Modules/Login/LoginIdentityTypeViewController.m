//
//  LoginIdentityTypeViewController.m
//  XiangFa
//
//  Created by Jeremy on 2017/5/26.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "LoginIdentityTypeViewController.h"

#import "SetUserTypeRequest.h"

@interface LoginIdentityTypeViewController ()

@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIImageView *borrowerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *borrowerCircleImageView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIImageView *managerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *managerCircleImageView;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, assign) NSInteger type;

@end

@implementation LoginIdentityTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.leftButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    CGSize titleSize = [@"请稍后..." sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:self.submitButton.titleLabel.font.fontName size:self.submitButton.titleLabel.font.pointSize]}];
    CGFloat leftSpace = (self.submitButton.frame.size.width - titleSize.width) / 2 - 30;
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(leftSpace, 10, 20, 20)];
    [self.activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [self.submitButton addSubview:self.activityView];

    self.submitButton.layer.masksToBounds = YES;
    self.submitButton.layer.cornerRadius = 4.0;
    [self.submitButton setBackgroundImage:[UIImage imageWithColor:kGlobalTintColor] forState:UIControlStateNormal];
    [self.submitButton setBackgroundImage:[UIImage imageWithColor:kGlobalTintColor] forState:UIControlStateHighlighted];
    [self.submitButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#CCCCCC"]] forState:UIControlStateDisabled];
    [self.submitButton setTitle:@"请稍后..." forState:UIControlStateSelected | UIControlStateDisabled];
    [self.submitButton setBackgroundImage:[UIImage imageWithColor:kGlobalTintColor] forState:UIControlStateSelected | UIControlStateDisabled];
    
    [self.submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectButtonAction:(UIButton *)sender {
    
    if (sender == self.leftButton) {
        
        [self.borrowerImageView setHighlighted:YES];
        [self.borrowerCircleImageView setHighlighted:YES];
        [self.managerImageView setHighlighted:NO];
        [self.managerCircleImageView setHighlighted:NO];
        self.type = 1;
    } else {
        
        [self.borrowerImageView setHighlighted:NO];
        [self.borrowerCircleImageView setHighlighted:NO];
        [self.managerImageView setHighlighted:YES];
        [self.managerCircleImageView setHighlighted:YES];
        self.type = 2;
    }
    
    self.submitButton.enabled = YES;
}

- (void)submitButtonAction:(UIButton *)sender {
    
    [self.centerView setUserInteractionEnabled:NO];
    self.submitButton.enabled = NO;
    self.submitButton.selected = YES;
    [self.activityView startAnimating];
    
    
    SetUserTypeRequest *setUserTypeRequest = [[SetUserTypeRequest alloc] init];
    setUserTypeRequest.ddtUserType = self.type;
    setUserTypeRequest.token = self.token;
    [setUserTypeRequest mlStartWithCompletionBlockWithSuccess:^(__kindof SetUserTypeRequest *request) {
        
        [self hide];
        if (self.block) {
            self.block(self.type);
        }
        
    } failure:^(__kindof SetUserTypeRequest *request) {
        
        [self.centerView setUserInteractionEnabled:YES];
        self.submitButton.enabled = YES;
        self.submitButton.selected = NO;
        [self.activityView stopAnimating];
    }];
}

- (void)showFrom:(UIViewController *)viewController {
    
    [viewController.view addSubview:self.view];
    [viewController addChildViewController:self];
    [self.view setFrame:viewController.view.bounds];
    
    CABasicAnimation *scaleAnimation    = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue            = [NSNumber numberWithFloat:0.0];
    scaleAnimation.toValue              = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration             = 0.25;
    scaleAnimation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.centerView.layer addAnimation:scaleAnimation forKey:nil];
}

- (void)hide {
    
    CABasicAnimation *scaleAnimation    = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue            = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue              = [NSNumber numberWithFloat:0.0];
    scaleAnimation.duration             = 0.25;
    scaleAnimation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.centerView.layer addAnimation:scaleAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
