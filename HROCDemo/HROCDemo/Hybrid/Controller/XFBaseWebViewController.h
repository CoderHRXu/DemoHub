//
//  XFBaseWebViewController.h
//  XiangFa
//
//  Created by xuhaoran on 2017/5/9.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "XFBaseViewController.h"

@interface XFBaseWebViewController : XFBaseViewController

/** 外链URL  */
@property (nonatomic, strong) NSString *urlStr;
/** 标题  */
@property (nonatomic, strong) NSString *titleStr;

/** 禁止跳转的外链  */
@property (nonatomic, strong) NSArray *forbiddenUrlArray;

/** webview  */
@property (nonatomic, strong) UIWebView *webView;

@end
