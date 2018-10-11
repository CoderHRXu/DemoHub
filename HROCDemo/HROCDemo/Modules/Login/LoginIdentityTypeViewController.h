//
//  LoginIdentityTypeViewController.h
//  XiangFa
//
//  Created by Jeremy on 2017/5/26.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginIdentityTypeBlock)(NSInteger index);

@interface LoginIdentityTypeViewController : UIViewController

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) LoginIdentityTypeBlock block;

- (void)showFrom:(UIViewController *)viewController;
- (void)hide;

@end
