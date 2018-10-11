//
//  XFTabBarController.m
//  HROCDemo
//
//  Created by Jeremy on 2016/12/13.
//  Copyright © 2016年 RJS. All rights reserved.
//

#import "XFTabBarController.h"


#import "AViewController.h"
#import "BViewController.h"
#import "CViewController.h"
#import "DViewController.h"

@interface XFTabBarController ()

/** 借款人-首页  */
@property (nonatomic, strong) UINavigationController *bHomeNav;
/** 借款人-发现  */
@property (nonatomic, strong) UINavigationController *bDiscoveryNav;
/** 借款人-我的  */
@property (nonatomic, strong) UINavigationController *bPersonalNav;

/** 首页  */
@property (nonatomic, strong) UINavigationController *homeNav;
/** 单子  */
@property (nonatomic, strong) UINavigationController *submittedNav;
/** 工作台  */
@property (nonatomic, strong) UINavigationController *workbenchNav;
/** 我的  */
@property (nonatomic, strong) UINavigationController *personalNav;

@end

@implementation XFTabBarController

+ (instancetype)shareInstance {
    static XFTabBarController *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        instance = [[XFTabBarController alloc] init];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.tintColor = kGlobalTintColor;
    self.tabBar.translucent = NO;
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:kLineGrayColor size:CGSizeMake(OnePixel, OnePixel)]];
    

}

- (void)switchAppTypeTo:(DDTUserType)appType {
    
//    CacheHandlerInstance.currentSetting.appType = appType;
//    SaveChangesToDB;
//
    if (appType == DDTUserTypeBorrower) {
     
        self.viewControllers = @[self.bHomeNav, self.bDiscoveryNav, self.bPersonalNav];
        [self setSelectedIndex:0];

    } else {
        
        self.viewControllers = @[self.homeNav, self.submittedNav, self.workbenchNav, self.personalNav];
        [self setSelectedIndex:0];
    }
}

- (void)loadBorrowerControllers {
    
    if (self.viewControllers.count == 3) {
        return;
    } else if (self.viewControllers.count == 4) {
        [self setSelectedIndex:0];
    }
    self.viewControllers = @[self.bHomeNav, self.bDiscoveryNav, self.bPersonalNav];
}

- (void)loadManagerControllers {
    
    if (self.viewControllers.count == 4) {
        return;
    } else if (self.viewControllers.count == 3) {
        [self setSelectedIndex:0];
    }
    self.viewControllers = @[self.homeNav, self.submittedNav, self.workbenchNav, self.personalNav];
}

- (UINavigationController *)bHomeNav {
    
    if (!_bHomeNav) {
        
        AViewController *homeVC = [[AViewController alloc] init];
        homeVC.navigationItem.title = @"A";
        _bHomeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
        _bHomeNav.tabBarItem.title = @"A";
        _bHomeNav.tabBarItem.image = [[UIImage imageNamed:@"borrower_tab_ic_loan_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _bHomeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"borrower_tab_ic_loan_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _bHomeNav;
}

- (UINavigationController *)bDiscoveryNav {
    
    if (!_bDiscoveryNav) {
        
        BViewController *discoveryVC = [[BViewController alloc] init];
        discoveryVC.navigationItem.title = @"B";
        _bDiscoveryNav = [[UINavigationController alloc] initWithRootViewController:discoveryVC];
        _bDiscoveryNav.tabBarItem.title = @"B";
        _bDiscoveryNav.tabBarItem.image = [[UIImage imageNamed:@"borrower_tab_ic_find_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _bDiscoveryNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"borrower_tab_ic_find_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _bDiscoveryNav;
}

- (UINavigationController *)bPersonalNav {
    
    if (!_bPersonalNav) {
        
        CViewController *personalVC = [[CViewController alloc] init];
        personalVC.navigationItem.title = @"C";
        _bPersonalNav = [[UINavigationController alloc] initWithRootViewController:personalVC];
        _bPersonalNav.tabBarItem.title = @"C";
        _bPersonalNav.tabBarItem.image = [[UIImage imageNamed:@"borrower_tab_mine_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _bPersonalNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"borrower_tab_mine_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _bPersonalNav;
}

- (UINavigationController *)homeNav {
    
    if (!_homeNav) {
        
        AViewController *homeCenterVC = [[AViewController alloc] init];
        homeCenterVC.navigationItem.title = @"A";
        _homeNav = [[UINavigationController alloc] initWithRootViewController:homeCenterVC];
        _homeNav.tabBarItem.title = @"A";
        _homeNav.tabBarItem.image = [[UIImage imageNamed:@"tab_home_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _homeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_home_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _homeNav;
}

- (UINavigationController *)submittedNav {
    
    if (!_submittedNav) {
        
        BViewController *submittedListVC = [[BViewController alloc] init];
        submittedListVC.navigationItem.title = @"B";
        _submittedNav = [[UINavigationController alloc] initWithRootViewController:submittedListVC];
        _submittedNav.tabBarItem.title = @"B";
        _submittedNav.tabBarItem.image = [[UIImage imageNamed:@"tab_product_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _submittedNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_product_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _submittedNav;
}

- (UINavigationController *)workbenchNav {
    
    if (!_workbenchNav) {
        
        CViewController *workbenchVC = [[CViewController alloc] init];
        workbenchVC.navigationItem.title = @"C";
        _workbenchNav = [[UINavigationController alloc] initWithRootViewController:workbenchVC];
        _workbenchNav.tabBarItem.title = @"C";
        _workbenchNav.tabBarItem.image = [[UIImage imageNamed:@"tab_workbench_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _workbenchNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_workbench_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _workbenchNav;
}

- (UINavigationController *)personalNav {
    
    if (!_personalNav) {
        
        DViewController *personalVC = [[DViewController alloc] init];
        personalVC.navigationItem.title = @"我";
        _personalNav = [[UINavigationController alloc] initWithRootViewController:personalVC];
        _personalNav.tabBarItem.title = @"我的";
        _personalNav.tabBarItem.image = [[UIImage imageNamed:@"tab_mine_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _personalNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_mine_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _personalNav;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
