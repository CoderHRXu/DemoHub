//
//  XFBaseViewController.m
//  HROCDemo
//
//  Created by Jeremy on 16/8/16.
//  Copyright © 2018年 XHR. All rights reserved.
//

#import "XFBaseViewController.h"
#import "LoginViewController.h"

@interface XFBaseViewController ()

@end

@implementation XFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [NotificationManager addObsrever:self selector:@selector(handleUserStatusChanged:) name:XFUserStatusChanged];
    [NotificationManager addObsrever:self selector:@selector(handleTabBarShouldSelect:) name:XFTabBarSelectedChanged];
    [NotificationManager addObsrever:self selector:@selector(netWorkStatusChanged:) name:XFNetWorkStatusChanged];
    [NotificationManager addObsrever:self selector:@selector(backToNavRootViewController) name:XFBackToRootViewController];
    [NotificationManager addObsrever:self selector:@selector(showLoginStatusAlertView) name:XFShowLoginStatusAlertView];

    // NavigationBar样式配置
    [self setupNavigationBar];
    
    // 全局样式
    [[UITextField appearance] setTintColor:kGlobalTintColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self setupNavigationBarTintColor];
}

- (void)handleUserStatusChanged:(NSNotification *)noti {
    
    [self userStatusChanged:CacheHandlerInstance.userLoggedin];
}

- (void)handleTabBarShouldSelect:(NSNotification *)noti {
    
    NSString *currentTitle = self.navigationController.tabBarItem.title;
    NSInteger selectedIndex = 0;

    if ([noti.object isEqualToString:currentTitle]) {
        [self tabBarShouldSelectController];
    }
    
//    if (CacheHandlerInstance.currentSetting.appType == DDTUserTypeUndefined || CacheHandlerInstance.currentSetting.appType == DDTUserTypeBorrower) {
//        
//        if ([currentTitle isEqualToString:@"借款"]) {
//            selectedIndex = 0;
//        } else if ([currentTitle isEqualToString:@"发现"]) {
//            selectedIndex = 1;
//        } else {
//            selectedIndex = 2;
//        }
//    } else {
//        
//        if ([currentTitle isEqualToString:@"首页"]) {
//            selectedIndex = 0;
//        } else if ([currentTitle isEqualToString:@"单子"]) {
//            selectedIndex = 1;
//        } else if ([currentTitle isEqualToString:@"工作台"]) {
//            selectedIndex = 2;
//        } else {
//            selectedIndex = 3;
//        }
//    }
    [self tabBarShouldSelect:[noti.object integerValue]];
}


- (void)setupNavigationBar {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObject: [UIColor whiteColor]
                                                                                                 forKey: NSForegroundColorAttributeName]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}
                                                                                            forState:UIControlStateNormal];
}

#pragma mark - 
- (void)setupNavigationBarHidden {
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)setupNavigationBarTransparent {
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],
                                                                      NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                      }];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:kGlobalTintColor];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)setupNavigationBarTintColor {
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],
                                                                      NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                      }];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:kGlobalTintColor];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)setupNavigationBarWhite {

    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:kLineGrayColor size:CGSizeMake(OnePixel, OnePixel)]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],
                                                                      NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"]
                                                                      }];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHexString:@"#333333"]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setupNavigationBarGray {
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],
                                                                      NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"]
                                                                      }];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHexString:@"#333333"]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"F9F9F9"]];
    
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleDefault;
}

- (void)addMJRefreshGifHeaderWithTableView:(UITableView *)tableView refreshingAction:(SEL)action{
    
    NSMutableArray *mjRefreshingImages = [NSMutableArray array];
    for (int i = 1; i <= 18; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"small_refresh_picture_%d", i]];
        [mjRefreshingImages addObject:image];
    }
    
    NSMutableArray *mjPullingImages = [NSMutableArray array];
    UIImage *mjPullingImage = [UIImage imageNamed:[NSString stringWithFormat:@"small_refresh_picture_18"]];
    [mjPullingImages addObject:mjPullingImage];
        
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:action];
    [header setImages:mjRefreshingImages   forState:MJRefreshStateRefreshing];
    [header setImages:mjRefreshingImages   forState:MJRefreshStateIdle];
    [header setImages:mjPullingImages      forState:MJRefreshStatePulling];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    header.automaticallyChangeAlpha     = NO;
    tableView.mj_header                 = header;
}

- (void)addLeftBackBtnAndBandAction:(void (^)(UIButton *leftBtn))bandAction {
    
    UIButton *leftButton            = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame                = CGRectMake(0, 0, 20, 20);
    leftButton.titleLabel.font      = [UIFont systemFontOfSize:16.0];
    
    [leftButton setBackgroundImage:[UIImage imageNamed:@"navigationBack"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButtonItem      = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *negativeSpacer         = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width                    = -5;
    self.navigationItem.leftBarButtonItems  = [NSArray arrayWithObjects:negativeSpacer,leftBarButtonItem,nil];
    
    bandAction(leftButton);
}

- (void)addLeftBtnWithTitle:(NSString *)btnTitle andBandAction:(void (^)(UIButton *leftBtn))bandAction {
    
    UIButton *leftButton            = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame                = CGRectMake(0, 0, 80, self.navigationController.navigationBar.frame.size.height);
    leftButton.titleLabel.font      = [UIFont systemFontOfSize:16.0];
    
    [leftButton setTitle:btnTitle forState:UIControlStateNormal];
    
    leftButton.contentHorizontalAlignment   = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *leftBarButtonItem      =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem   = leftBarButtonItem;
    
    bandAction(leftButton);
}

- (void)addRightBtnWithTitle:(NSString *)btnTitle andBandAction:(void (^)(UIButton *rightBtn))bandAction {
    
    UIButton *rightButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame           = CGRectMake(0, 0, 80, self.navigationController.navigationBar.frame.size.height);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    [rightButton setTitle:btnTitle forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *rightBarButtonItem     =[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem  = rightBarButtonItem;
    
    bandAction(rightButton);
}

- (void)addRightBtnWithImage:(NSString *)imageName andTarget:(id)target andAction:(SEL)action {
    
    UIButton *rightButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame           = CGRectMake(0, 0, 80, self.navigationController.navigationBar.frame.size.height);
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *rightBarButtonItem     =[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem  = rightBarButtonItem;
    
}

- (void)presentLoginViewController {
    
    LoginViewController *loginViewController    = [[LoginViewController alloc] init];
    UINavigationController *nav                 = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)userStatusChanged:(BOOL)loggedOut {
    //子类实现
}

- (void)tabBarShouldSelect:(NSInteger)index {
    //子类实现
}

- (void)tabBarShouldSelectController {
    //子类实现
}

- (void)netWorkStatusChanged:(NSNotification *)notification {
    // 子类实现
}

//显示登录提示框
- (void)showLoginStatusAlertView {
    
    //TODO:Hailong Temp 为了和老代码做兼容，此处再处理一遍user信息
    [CacheHandlerInstance resetCache];
    
    UINavigationController *currectNavigationController = [[XFTabBarController shareInstance] selectedViewController];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"您已在别处登录，请重新登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [currectNavigationController popToRootViewControllerAnimated:NO];
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        [currectNavigationController presentViewController:nav animated:YES completion:nil];
    }];
    [alertVC addAction:confirmAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//回退到根目录
- (void)backToNavRootViewController {
    
    UINavigationController *currectNavigationController =  [[XFTabBarController shareInstance] selectedViewController];
    [currectNavigationController popToRootViewControllerAnimated:NO];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)dealloc {
    
    [NotificationManager removeObserver:self];
}
@end
