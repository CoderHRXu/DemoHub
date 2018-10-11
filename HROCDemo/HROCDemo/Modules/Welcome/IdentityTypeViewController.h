//
//  IdentityTypeViewController.h
//  HROCDemo
//
//  Created by Jeremy on 2017/8/15.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IdentityTypeViewController;
@protocol IdentityTypeDelegate <NSObject>

- (void)loadPageWithAppType:(NSInteger)appType;
@end

@interface IdentityTypeViewController : UIViewController

@property (nonatomic, assign) id<IdentityTypeDelegate> delegate;
@end
