//
//  ImageViewController.m
//  HROCDemo
//
//  Created by Jeremy on 2017/8/15.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initView];
}

- (void)initView {
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    self.imageView.image = [UIImage imageNamed:self.imageNameString];
    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
