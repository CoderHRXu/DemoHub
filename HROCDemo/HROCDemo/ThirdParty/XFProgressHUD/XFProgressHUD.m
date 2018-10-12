//
//  XFProgressHUD.m
//  Dingdong
//
//  Created by Jeremy Pan on 16/7/15.
//  Copyright © 2018年 XHR. All rights reserved.
//

#import "XFProgressHUD.h"

@implementation XFProgressHUD

+ (void)showNormalHUDfromView:(UIView *)targetView withString:(NSString *)textString {
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:targetView];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.opacity = 0.75;
    hud.dimBackground = NO;
    hud.detailsLabelText = textString;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15.0];

    [hud hide:YES afterDelay:20.0];

    NSMutableArray *hudImages = [NSMutableArray array];
    for (int i = 1; i <= 18; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"larger_refresh_picture_%d", i]];
        [hudImages addObject:image];
    }
    UIImageView *hudImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"larger_refresh_picture_1"]];
    hudImageView.animationImages = hudImages;
    hudImageView.animationDuration = 1;
    hudImageView.animationRepeatCount = 0;
    [hudImageView startAnimating];
    hud.customView = hudImageView;
}

+ (void)hideHUDfromView:(UIView *)targetView {
    
    [MBProgressHUD hideHUDForView:targetView animated:YES];
}

#pragma mark - Auto HUD
+ (void)showAutomaticallyDisappearHUDfromView:(UIView *)targetView withString:(NSString *)textString {
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:targetView];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    }
    hud.mode = MBProgressHUDModeText;
    hud.opacity = 0.75;
    hud.margin = 12.f;
    hud.detailsLabelText = textString;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.25];
}

+ (void)showAutoHUDfromView:(UIView *)targetView withString:(NSString *)textString delay:(CGFloat)second {
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:targetView];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    }
    hud.mode = MBProgressHUDModeText;
    hud.opacity = 0.75;
    hud.margin = 12.f;
    hud.detailsLabelText = textString;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:second];
}

#pragma mark - Progress HUD
+ (void)showProgressHUDformView:(UIView *)targetView withString:(NSString *)textString withProgress:(CGFloat)progress {
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:targetView];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    }
    hud.mode = MBProgressHUDModeDeterminate;
    hud.opacity = 0.75;
    hud.dimBackground = NO;
    hud.detailsLabelText = textString;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15.0];
    hud.progress = progress;
}

#pragma mark - Window HUD
+ (void)showNormalHUDfromWindow:(NSString *)textString {
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:UIApplication.sharedApplication.keyWindow];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.keyWindow animated:YES];
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.opacity = 0.75;
    hud.dimBackground = NO;
    hud.detailsLabelText = textString;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15.0];
    [hud hide:YES afterDelay:20.0];
    
    NSMutableArray *hudImages = [NSMutableArray array];
    for (int i = 1; i <= 18; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"larger_refresh_picture_%d", i]];
        [hudImages addObject:image];
    }
    UIImageView *hudImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"larger_refresh_picture_1"]];
    hudImageView.animationImages = hudImages;
    hudImageView.animationDuration = 1;
    hudImageView.animationRepeatCount = 0;
    [hudImageView startAnimating];
    hud.customView = hudImageView;
}

+ (void)hideHUDfromWindow {
    
    [MBProgressHUD hideHUDForView:UIApplication.sharedApplication.keyWindow animated:YES];
}

#pragma mark - Auto Window HUD
+ (void)showAutomaticallyDisappearWindowHUDwithString:(NSString *)textString {
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:UIApplication.sharedApplication.keyWindow];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.keyWindow animated:YES];
    }
 
    hud.mode = MBProgressHUDModeText;
    hud.opacity = 0.75;
    hud.margin = 12.f;
    hud.detailsLabelText = textString;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.10];
}

+ (void)showAutoWindowHUDwithString:(NSString *)textString delay:(CGFloat)second {
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:UIApplication.sharedApplication.keyWindow];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.keyWindow animated:YES];
    }
    
    hud.mode = MBProgressHUDModeText;
    hud.opacity = 0.75;
    hud.margin = 12.f;
    hud.detailsLabelText = textString;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:second];
}

@end
