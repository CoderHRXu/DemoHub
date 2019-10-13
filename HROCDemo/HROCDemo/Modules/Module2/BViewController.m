//
//  BViewController.m
//  HROCDemo
//
//  Created by haoran on 2018/10/11.
//  Copyright © 2018年 Sunfit. All rights reserved.
//

#import "BViewController.h"
#import "FeedBackSenceViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    FeedBackSenceViewController *vc = [[FeedBackSenceViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
