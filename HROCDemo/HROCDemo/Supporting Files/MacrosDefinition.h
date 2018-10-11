//
//  MacrosDefinition.h
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 05/02/2017.
//  Copyright © 2017 RJS. All rights reserved.
//

// 声明 公用的宏定义
// 颜色
#define KColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)        RGBA(r, g, b, 1.0f)
#define KRandomColor        KColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
// 尺寸
#define KScreenW                                [UIScreen mainScreen].bounds.size.width
#define KScreenH                                [UIScreen mainScreen].bounds.size.height
#define OnePixel                                1.f / UIScreen.mainScreen.scale //一像素
// 设备类型
#define IS_IPHONE4                              [UIScreen mainScreen].bounds.size.height == 480
#define IS_IPHONE5                              [UIScreen mainScreen].bounds.size.height == 568
#define IS_IPHONE6                              [UIScreen mainScreen].bounds.size.width == 375
#define IS_IPHONE6P                             [UIScreen mainScreen].bounds.size.width == 414
#define IS_IPHONEX                              [UIScreen mainScreen].currentMode.size.width == 1125 && [UIScreen mainScreen].currentMode.size.height == 2436

// 应用全局颜色
#define kGlobalTintColor                        [UIColor colorWithRed:206/255.0 green:167/255.0 blue:110/255.0 alpha:1.0]   //#CEA76E
#define kGlobalGrayColor                        [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]   //#F5F5F5
#define kLineGrayColor                          [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]   //#EEEEEE
#define kButtonDisableGrayColor                 [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]   //#CCCCCC
// 默认占位图
#define kHeadImagePlaceholder                   [UIImage imageNamed:@"AppIcon60x60"]
// 沙盒路径
#define DocumentDirectory                       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

// Log宏
#define XFFunction  NSLog(@"%s",__func__);

#if  (DEBUG&&SIT)  ||  (DEBUG&&UAT)  || DEBUG
#define XFLog(...)  NSLog(__VA_ARGS__)
#define NSLog(...)  NSLog(__VA_ARGS__)
#else
#define XFLog(...)
#define NSLog(...)
#endif


///操作的草稿的Action
#define ActionQuery                     @"Q" //查询
#define ActionUpdate                    @"U" //更新
/** 识别类型 身份证正面-2，身份证反面-3，行驶证-6  */
#define CarTypeIdCardFront              @"2"
#define CarTypeIdCardBack               @"3"
#define CarTypeDriverLicence            @"6"
///通知的宏定义
#define XFAppRemotePush                     @"RemotePushNotification"
#define XFUserStatusChanged                 @"UserStatusChangedNotification"
#define XFBackToRootViewController          @"BackToRootViewController"
#define XFShowLoginStatusAlertView          @"ShowLoginStatusAlertView"
#define XFTabBarSelectedChanged             @"XFTabBarControllerNotification"
#define XFRefreshHomeCenterNews             @"RefreshHomeCenterNewsNotification"
#define XFRefreshOrderCenter                @"RefreshOrderCenterNewsNotification"
#define XFNetWorkStatusChanged              @"NetWorkStatusChanged"
#define XFBankAccountVC                     @"BankAccountVC"


///第三方服务配置
///友盟
#if  SIT  ||  UAT
#define kUmengkey           @"596744d504e2052c42000d59"
#elif (DEBUG&&PRO)
#define kUmengkey           @"595458417666131a3d0013c5"
#else
#define kUmengkey           @"595458417666131a3d0013c5"
#endif

///个推
#if  SIT || UAT
#define kAppId              @"qCgQ3Y5Ztr7aWYHVlNmqU9"
#define kAppKey             @"NBdolfu7ez6Unqn1R9vUP6"
#define kAppSecret          @"AXn3nKCQlk6UU5jwDLtFn9"
#elif (DEBUG&&PRO)
#define kAppId              @"OPODiY59Rc63TZcB3v0j87"
#define kAppKey             @"AjtsuG2rQeAH47zt9GOVM3"
#define kAppSecret          @"w35SYmOwS29LkVY427cwe"
#else
#define kAppId              @"OPODiY59Rc63TZcB3v0j87"
#define kAppKey             @"AjtsuG2rQeAH47zt9GOVM3"
#define kAppSecret          @"w35SYmOwS29LkVY427cwe"
#endif
///图片Referer
#if SIT
#define kReferer           @"http://172.16.88.167:5959/xiangfajr"
#elif UAT
#define kReferer           @"http://172.16.88.168:8445/xiangfajr"
#else
#define kReferer           @"http://japi.xiangfajr.com/xfjr"
#endif

