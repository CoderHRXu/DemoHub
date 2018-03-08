//
//  ChatViewController.m
//  QIYUDemo
//
//  Created by haoran on 2018/3/8.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (instancetype)init
{
    self = [[QYSDK sharedSDK] sessionViewController];
    if (self) {
        QYSource *source    = [[QYSource alloc] init];
        source.title        =  @"极课教师Beta";
        source.urlString    = @"https://www.fclassroom.com/";
        self.sessionTitle   = @"极课教师Beta";
        self.source         = source;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onBack:)];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)onBack:(id)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
