//
//  XFBaseWebViewController.m
//  XiangFa
//
//  Created by xuhaoran on 2017/5/9.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "XFBaseWebViewController.h"

/*****  适用于外部第三方Web链接，无JS注入   ***/
@interface XFBaseWebViewController () <UIWebViewDelegate>

@end

@implementation XFBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    [self setupWebView];
    [self loadWebView];
}

#pragma mark - UI
- (void)setupWebView {

    self.webView                    = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH - 64)];
    self.webView.delegate           = self;
    self.webView.backgroundColor    = kGlobalGrayColor;
    self.webView.scrollView.bounces = NO;
    [self.webView setScalesPageToFit:YES];
    [self.view addSubview:self.webView];
}

- (BOOL)navigationShouldPopOnBackButton {
    [self tapBack];
    return NO;
}

/**
 后退点击事件
 */
- (void)tapBack {
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - method
/**
 加载WebView
 */
- (void)loadWebView {
    
    if (self.urlStr == nil) return;
    [XFProgressHUD showNormalHUDfromView:self.view withString:nil];
    
    NSURLRequest *requst =  [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [self.webView loadRequest:requst];
}



#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSURL *url = [request URL];
    if ([self.forbiddenUrlArray containsObject:url.absoluteString]) {
        return NO;
    } else {
        return  YES;
    }
}

/**
 页面加载完成
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [XFProgressHUD hideHUDfromView:self.view];
    
    if (!self.titleStr.length) {
        self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    
    //取消长按后出现复制等信息
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"$(document).triggerHandler('deviceready')"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [XFProgressHUD hideHUDfromView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
