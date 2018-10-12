//
//  XFBaseViewController.h
//  HROCDemo
//
//  Created by Jeremy on 16/8/16.
//  Copyright © 2018年 XHR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFBaseViewController : UIViewController

@property (nonatomic) BOOL navColorIsWhiteOrBlue;

/**
 
 给TableView 加MJ刷新的动画Header。 去除以前block 的调用形式，使代码更简洁。

 @param tableView 目标Tableview
 
 @param action 刷新时调用的Action, 它的target 是self
 */
- (void)addMJRefreshGifHeaderWithTableView:(UITableView *)tableView refreshingAction:(SEL)action;

- (void)addLeftBackBtnAndBandAction:(void (^)(UIButton *leftBtn))bandAction;

- (void)addLeftBtnWithTitle:(NSString *)btnTitle andBandAction:(void (^)(UIButton *leftBtn))bandAction;

- (void)addRightBtnWithTitle:(NSString *)btnTitle andBandAction:(void (^)(UIButton *rightBtn))bandAction;

- (void)addRightBtnWithImage:(NSString *)imageName andTarget:(id)target andAction:(SEL)action;


/**
 弹出登录VC
 */
- (void)presentLoginViewController;


- (void)backToNavRootViewController;

/**
 显示登录提示框
 */
- (void)showLoginStatusAlertView;

/**
 
 用户的登录登出状态的回调，子类实现方法，不可手动调用。

 @param userLoggedin User 是否登录状态
 */
- (void)userStatusChanged:(BOOL)userLoggedin;

/**
 接受TabBar点击事件

 @param index 将要选中的Index
 */
- (void)tabBarShouldSelect:(NSInteger)index;

/**
 当前Controller所在TabBarItem将要被选中
 */
- (void)tabBarShouldSelectController;

/**
 网络状态发生变化
 */
- (void)netWorkStatusChanged:(NSNotification *)notification;

/**
 隐藏导航条
 */
- (void)setupNavigationBarHidden;

/**
 设置导航条为背景透明
 */
- (void)setupNavigationBarTransparent;

/**
 设置导航条为白色
 */
- (void)setupNavigationBarWhite;

/**
 设置导航条为全局主题色
 */
- (void)setupNavigationBarTintColor;

/**
 设置导航条为灰色
 */
- (void)setupNavigationBarGray;

@end
