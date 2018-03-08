//
//  ViewController.m
//  QIYUDemo
//
//  Created by haoran on 2018/3/8.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"

#import <QIYU_iOS_SDK/QYSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)btnClick:(UIButton *)btn {
    
    ChatViewController *vc          = [[ChatViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    UINavigationController *nav     = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)dealloc{
    
}


@end
