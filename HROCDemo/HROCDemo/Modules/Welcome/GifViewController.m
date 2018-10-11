//
//  GifViewController.m
//  HROCDemo
//
//  Created by Jeremy on 16/8/30.
//  Copyright © 2016年 RJS. All rights reserved.
//

#import "GifViewController.h"

@interface GifViewController ()

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor               = kGlobalGrayColor;
    self.webView                            = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    self.webView.backgroundColor            = kGlobalGrayColor;
    self.webView.scrollView.bounces         = NO;
    self.webView.scalesPageToFit            = YES;
    self.webView.userInteractionEnabled     = NO;//用户不可交互
    self.webView.scalesPageToFit            = YES;
    
    NSData *gifData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"shityou" ofType:@"gif"]];
    [self.webView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
    [self.view addSubview:self.webView];
}

- (void)loadGifView {
    
    [self.view setFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    [window addSubview:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
    });
}
@end
