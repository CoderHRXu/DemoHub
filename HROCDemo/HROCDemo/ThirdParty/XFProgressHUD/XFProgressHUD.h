//
//  XFProgressHUD.h
//  Dingdong
//
//  Created by Jeremy Pan on 16/7/15.
//  Copyright © 2018年 XHR. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface XFProgressHUD : MBProgressHUD

/**
 普通HU的显示
 
 @param targetView 添加HUD的目标View
 @param textString HUD显示的文本字符串（无需文字则传nil）
 */
+ (void)showNormalHUDfromView:(UIView *)targetView withString:(NSString *)textString;

/**
 普通等待HUD的隐藏
 
 @param targetView 添加HUD的目标View
 */
+ (void)hideHUDfromView:(UIView *)targetView;

/**
 View HUD纯文本自动消失

 @param targetView 添加HUD的目标View
 @param textString HUD显示的文本字符串
 */
+ (void)showAutomaticallyDisappearHUDfromView:(UIView *)targetView withString:(NSString *)textString;


/**
 View HUD纯文本自动消失

 @param targetView 添加HUD的目标View
 @param textString HUD显示的文本字符串
 @param second 延迟时间
 */
+ (void)showAutoHUDfromView:(UIView *)targetView withString:(NSString *)textString delay:(CGFloat)second;
/**
 进度条HUD

 @param targetView 添加HUD的目标View
 @param textString HUD显示的文本字符串
 */
+ (void)showProgressHUDformView:(UIView *)targetView withString:(NSString *)textString withProgress:(CGFloat)progress;


#pragma mark - WindowHUD
/**
 WindowHUD show

 @param textString HUD显示的文本字符串（无需文字则传nil）
 */
+ (void)showNormalHUDfromWindow:(NSString *)textString;

/**
 WindowHUD hide
 */
+ (void)hideHUDfromWindow;

/**
 WindowHUD纯文本自动消失

 @param textString HUD显示的文本字符串
 */
+ (void)showAutomaticallyDisappearWindowHUDwithString:(NSString *)textString;


/**
 WindowHUD纯文本自动消失

 @param textString HUD显示的文本字符串
 @param second 延迟时间
 */
+ (void)showAutoWindowHUDwithString:(NSString *)textString delay:(CGFloat)second;
@end
