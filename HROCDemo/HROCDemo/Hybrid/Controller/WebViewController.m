//
//  WebViewController.m
//  HROCDemo
//
//  Created by Jeremy Pan on 16/7/21.
//  Copyright © 2018年 XHR. All rights reserved.
//

#import "WebViewController.h"
#import "UIViewController+BackButtonHandler.h"
#import "AppInterface.h"

@interface WebViewController () <UIWebViewDelegate>
/** 协议  */
@property (nonatomic, retain) AppInterface *webProtocol;
/** JSContext  */
@property (nonatomic, weak) JSContext *context;
/** 是否打开为文档  */
@property (nonatomic, assign) BOOL isDocument;
/** 隐藏NavigationBar  */
@property (nonatomic, assign) BOOL hiddenNav;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getURLParam];
    [self loadWebView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNavigationBarTitle:) name:@"setTitleBar" object:nil];
}

- (BOOL)navigationShouldPopOnBackButton {
    [self tapBack];
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.hiddenNav) {
        
        [self setupNavigationBarHidden];
        
        if (@available(iOS 11.0, *)) {
            self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    } else {
        [self setupNavigationBarTintColor];
    }
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"$(document).triggerHandler('resume')"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.webView stringByEvaluatingJavaScriptFromString:@"$(document).triggerHandler('pause')"];
}

#pragma mark - method
/**
 读取URL参数获取URL类型
 */
- (void)getURLParam {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:self.url] resolvingAgainstBaseURL:NO];
    for (NSURLQueryItem *queryItem in components.queryItems) {
        self.hiddenNav = ([queryItem.name isEqualToString:@"titlehide"] && [queryItem.value isEqualToString:@"1"]);
    }
}

/**
 *  加载webView
 */
- (void)loadWebView {
    
    if (self.hiddenNav) {
        
        self.webView                    = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
        self.automaticallyAdjustsScrollViewInsets = NO;

    } else {
        
        self.webView                    = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH - 64)];
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    self.webView.delegate           = self;
    self.webView.backgroundColor    = kGlobalGrayColor;
    self.webView.scrollView.bounces = NO;
    [self.webView setScalesPageToFit:YES];
    [self.view addSubview:self.webView];
    
    [NSHTTPCookie add:@"source" value:@"ios" path:@"/" domain:@".^filecookies^" expires:nil];
    [NSHTTPCookie add:@"source" value:@"ios" path:@"/" domain:CookieDomain expires:nil];
    [NSHTTPCookie add:@"rjsfrom" value:@"HROCDemo" path:@"/" domain:@".rjs.com" expires:nil];
    NSURLRequest *requst =  [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [self.webView loadRequest:requst];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (self.headTitle) {
        return true;
    }
    
    NSURL *url = [request URL];
    if([url.scheme isEqualToString:@"tel"]){
        return true;
    }
    
    switch (navigationType) {
        case UIWebViewNavigationTypeOther:
            return true;
            break;
        default:
            if ([url.scheme isEqualToString:@"file"]) {
                return true;
            }
            return false;
            break;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //加载标题
    if (!self.headTitle) {
        [self setTitle:[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"] rightItem:[self.webView stringByEvaluatingJavaScriptFromString:@"$('.header_right').html()"]];
    }
    
    //
    NSURLComponents *components = [NSURLComponents componentsWithURL:webView.request.URL resolvingAgainstBaseURL:NO];
    for (NSURLQueryItem *queryItem in components.queryItems) {
        self.isDocument = ([queryItem.name isEqualToString:@"contenttype"] && [queryItem.value isEqualToString:@"pdf"]);
    }

    //取消长按后出现复制等信息
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    //注入
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.webProtocol = [[AppInterface alloc] initWithController:self context:self.context];
    self.context[@"app"] = self.webProtocol;
    
    //打印异常
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
    };
    [self.webView stringByEvaluatingJavaScriptFromString:@"$(document).triggerHandler('deviceready')"];
}


#pragma mark - 
/**
 *  远程设置title
 *
 */
- (void)setNavigationBarTitle:(NSNotification *)text {
    
    NSString *title = [[text object] objectForKey:@"title"];
    NSString *rightTitle = [[text object] objectForKey:@"rightTitle"];
    [self setTitle:title rightItem:rightTitle];
}

/**
 *  设置title
 *

 */
- (void)setTitle:(NSString *)title rightItem:(NSString *)rightTitle {
    
    self.title = title;
    self.navigationItem.rightBarButtonItem = rightTitle.length ? [[UIBarButtonItem alloc] initWithTitle:rightTitle style:UIBarButtonItemStylePlain target:self action:@selector(tapRight)] : nil;
}

/**
 *  右边菜单事件
 
 */
- (void)tapRight {
    [self.webView stringByEvaluatingJavaScriptFromString:@"worf.web.rightClick()"];
}

/**
 *  后退点击事件
 *
 */
- (void)tapBack {
    
    if (self.headTitle) {
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (self.isDocument) {
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.webView stringByEvaluatingJavaScriptFromString:@"worf.web.goBack()"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"WebView内存警告!");
}


@end
