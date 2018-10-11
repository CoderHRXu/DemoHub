//
//  WelcomeViewController.h
//  HROCDemo
//
//  Created by Jeremy Pan on 16/7/18.
//  Copyright © 2016年 RJS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GoMainBlock) ();

@interface WelcomeViewController : UIViewController

@property (nonatomic, strong) GoMainBlock block;
@end
