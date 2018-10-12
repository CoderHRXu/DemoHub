//
//  WebViewController.h
//  HROCDemo
//
//  Created by Jeremy Pan on 16/7/21.
//  Copyright © 2018年 XHR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : XFBaseViewController
/** 页面url  */
@property (nonatomic, strong) NSString *url;
/** 页面Title  */
@property (nonatomic, strong) NSString *headTitle;
/** WebView  */
@property (nonatomic, strong) UIWebView *webView;
@end
