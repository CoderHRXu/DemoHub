//
//  AppDelegate.m
//  HROCDemo
//
//  Created by Jeremy Pan on 16/7/13.
//  Copyright © 2018年 XHR. All rights reserved.
//

#import "AppDelegate.h"
#import "AppLaunchManager.h"
#import "ZipArchive.h"
#import "WelcomeViewController.h"
#import "GetAppOnlineInfoRequest.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window                 = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initYTKNetConfig];
    [self addNetworkObbserve];
    
    [self initOpenShareSDK];
  
    //[self transferPushWithOptions:launchOptions];
    [self initDataBase];
    [self setupAppData];
    [self layoutMain];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 系统远程推送方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [NotificationManager postWithName:XFAppRemotePush object:userInfo];
}


- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    //如果OpenShare能处理这个回调，就调用block中的方法，如果不能处理，就交给其他（比如支付宝）。
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    } else return NO;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillTerminateNotification object:nil];
}

/** 初始化YTK */
- (void)initYTKNetConfig {
    
    AFSecurityPolicy *plicy     = [AFSecurityPolicy defaultPolicy];
    plicy.validatesDomainName   = NO;
    [YTKNetworkConfig sharedConfig].securityPolicy = plicy;
}

/** 初始化数据库 */
- (void)initDataBase {
    
    //[MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelVerbose];
   
}

/** 初始化应用数据 */
- (void)setupAppData {
//
//    //初始化当前用户
//    CacheHandlerInstance.currentUser    = [[DataBaseManager manager] loadLoggedInUser];
//    //初始化APP设置信息
//    AppSetting *currentSetting          = [[DataBaseManager manager] setupAppSetting];
//    NSString *currentAppVersion         = [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSString *currentBuildVersion       = [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleVersion"];
//    //保存至Settings.bundle中
//    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@ - %@", currentAppVersion, currentBuildVersion] forKey:@"kAppsVersionKey"];
//    //版本信息对比
//    if ([currentSetting.appVersion isEqualToString:currentAppVersion] && [currentSetting.buildVersion isEqualToString:currentBuildVersion]) {
//
//        currentSetting.isFirstLaunch    = NO;
//
//    } else {
//
//        currentSetting.isFirstLaunch    = YES;
//        currentSetting.h5Version        = @"0";
//    }
//
//    currentSetting.appVersion   = currentAppVersion;
//    currentSetting.buildVersion = currentBuildVersion;
//    CacheHandlerInstance.currentSetting = currentSetting;
//
//    //保存数据库
//    SaveChangesToDB;
    
    //设置图片加载Referer
//    [SDWebImageManager.sharedManager.imageDownloader setValue:kReferer forHTTPHeaderField:@"referer"];
//    SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;

    //全局设置键盘
    IQKeyboardManager.sharedManager.enable = YES;


    //定时执行
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60*60*2 target:self selector:@selector(getAppOnlineInfo) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [timer fire];
}

/** 获取应用在AppStore上的信息 */
- (void)getAppOnlineInfo {
    
    GetAppOnlineInfoRequest *checkRequest = [[GetAppOnlineInfoRequest alloc] init];
    [checkRequest mlStartWithCompletionBlockWithSuccess:^(GetAppOnlineInfoRequest *request) {

        
    } failure:^(__kindof BaseRequest *request) {
        
    }];
}

#pragma mark - 推送消息传递
/** 冷启动推送消息传递, 暂时没有跳转需求 */
- (void)transferPushWithOptions:(NSDictionary *)launchOptions {
    
    if (launchOptions) {
        
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (userInfo) {
            
            NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
            if (apsInfo) {
                
                [NotificationManager postWithName:XFAppRemotePush object:nil];
            }
        }
    }
}

#pragma mark - 加载布局
/** 开始加载页面布局 */
- (void)layoutMain {
    
//    if (CacheHandlerInstance.currentSetting.isFirstLaunch) {
    if (NO) {
        [self unZipFile];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [self loadWelcomeView];
    } else {
        
        [self loadTabBar];
//        [self loadWelcomeView];
    }
}

#pragma mark - 解压Zip资源文件
- (void)unZipFile {

#if     SIT
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"nxhd-V1.7.5-sit.zip"];
    NSLog(@"当前是167 SIT环境");
#elif   UAT
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"nxhd-V1.7.5-uat.zip"];
    NSLog(@"当前是168 UAT环境");
#else
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"nxhd-V1.7.5-pro.zip"];
    NSLog(@"当前是线上环境");
#endif
    
    NSString *toPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSError *unzipError = nil;
    [SSZipArchive unzipFileAtPath:sourcePath toDestination:toPath overwrite:YES password:nil error:&unzipError];
    
    if (unzipError == nil) {
        
        //禁用该目录iCloud同步
        NSString *allPath = [toPath stringByAppendingString:@"/wx2"];
        [[NSURL fileURLWithPath:allPath] setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:nil];
        NSLog(@"Zip包解压成功");
    } else {
        
        NSLog(@"Zip包解压失败-%@", unzipError);
    }
}


#pragma mark - 初始化Openshare
/** 初始化Openshare */
- (void)initOpenShareSDK{
    
    [OpenShare connectQQWithAppId:@"1104855675"];
    [OpenShare connectWeiboWithAppKey:@"3070058603"];
    [OpenShare connectWeixinWithAppId:@"wxe1062ddf84a06dad"];
}


#pragma mark - 首次打开加载欢迎轮播页
- (void)loadWelcomeView {
    
    WelcomeViewController *welVC = [[WelcomeViewController alloc] init];
    self.window.rootViewController = welVC;
    @weakify(self);
    welVC.block = ^ {
        
        @strongify(self);
        [self loadTabBar];
    };
}

#pragma mark - 加载整体布局
- (void)loadTabBar {
    
    XFTabBarController *tabBarController = [XFTabBarController shareInstance];
    tabBarController.delegate = self;
    [tabBarController loadManagerControllers];
    self.window.rootViewController = tabBarController;

   
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    UINavigationController *obj = (UINavigationController *)viewController;
    [[NSNotificationCenter defaultCenter] postNotificationName:XFTabBarSelectedChanged object:obj.tabBarItem.title userInfo:nil];
    return YES;
}

#pragma mark - 横屏处理
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    if (self.allowRotation) {
        return  UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

#pragma mark - 网络监听
/** 添加网络监听 */
- (void)addNetworkObbserve {

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:XFNetWorkStatusChanged object:@(status) userInfo:nil];
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"<<========未识别的网络========>>");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"<<========不可达的网络(未连接)========>>");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"<<========蜂窝数据========>>");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"<<========WiFi网络========>>");
                break;
            default:
                break;
        }
    }];
}

@end
