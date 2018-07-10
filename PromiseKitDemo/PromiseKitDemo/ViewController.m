//
//  ViewController.m
//  PromiseKitDemo
//
//  Created by haoran on 2018/7/10.
//  Copyright © 2018年 haoran. All rights reserved.
//

#import "ViewController.h"
#import <PromiseKit/PromiseKit.h>
#import <PromiseKit/UIView+AnyPromise.h>
#import <PromiseKit/PMKFoundation.h>
#import <PromiseKit/PMKUIKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    AnyPromise *promise = [UIView promiseWithDuration:1 animations:^{
        self.view.backgroundColor = [UIColor redColor];
    }];
    promise.then(^{
        NSLog(@"1111");
    }).then(^{
        NSLog(@"2222");
    });
    

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
