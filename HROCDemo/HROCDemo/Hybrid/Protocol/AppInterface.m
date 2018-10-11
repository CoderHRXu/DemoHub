//
//  WebProtocol.m
//  HROCDemo
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "AppInterface.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

#import "HttpDownloader.h"
#import "MD5Encryption.h"

// controllers
#import "WebViewController.h"
#import "LoginViewController.h"


// view


@interface AppInterface()

/**
 登录地址
 */
@property (nonatomic, retain) NSString *login_url;
/**
 viewController
 */
@property (nonatomic, weak) UIViewController * viewController;
/**
 js对象
 */
@property (nonatomic, retain) JSContext * context;

@end

@implementation AppInterface

- (AppInterface *)initWithController:(UIViewController *)controller context:(JSContext *)context {
    
    self = [super init];
    self.viewController = controller;
    self.context = context;
    return self;
}

/**
 回到首页
 */
- (void)toIndex:(NSString *)options {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

/**
 返回根页面
 */
- (void)toRoot {
    [self.viewController.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  后退
 *
 */
- (void)go:(NSString *)url Back:(BOOL)isHome {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (isHome) {
            [self.viewController.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [self.viewController.navigationController popViewControllerAnimated:YES];
        }
    });
}

/**
 *  前进

 */
- (void)goToHref:(NSString *)options {
    
    if (options != nil && options.length != 0) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithJsonString:options];
        if (dic != nil) {
            
            NSString *href = [dic objectForKey:@"url"];

            dispatch_async(dispatch_get_main_queue(), ^{
                
                WebViewController *webview = [[WebViewController alloc] init];
                
                NSString *urlString = nil;
                if ([href hasPrefix:@"http"]) {
                    
                    urlString = [NSString stringWithString:href];
                } else {
                    urlString = [NSString stringWithFormat:@"%@/%@",Constants.basePath, href];
                }
                
                webview.url = urlString;
                webview.hidesBottomBarWhenPushed = YES;
                [self.viewController.navigationController pushViewController:webview animated:YES];
            });
        }}
}

/**
 *  下载图片并保存至相册
 *
 *  @param url 图片地址
 */
- (void)saveImage:(NSString *)url {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSURL *imageUrl = [NSURL URLWithString:url];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        
        [image saveToAlbumWithCompletionBlock:^(NSURL * _Nullable assetURL, NSError * _Nullable error) {
            
            NSString *msg = error != nil ? @"保存系统相册失败" : @"已保存系统相册";
            [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:msg];
        }];
    });
}

/**
 *  远程设置标题

 */
- (void)setTitleBar:(NSString *)options{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (options !=nil && options.length!=0) {
            NSDictionary *dic = [NSDictionary dictionaryWithJsonString:options];
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"setTitleBar" object:dic]];
        }
    });
}

/**
 *  获取图片
 *
 */
- (void)getImage:(NSString *)options {
    
    if (options != nil && options.length != 0) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithJsonString:options];
        if (dic != nil) {
            
            NSString *urlString = [dic objectForKey:@"url"];
            NSString *callback = [dic objectForKey:@"callback"];
            
            if (urlString && callback) {
                
                NSString *directryPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingFormat:@"/imageCache"];
                if (![[NSFileManager defaultManager] fileExistsAtPath:directryPath]) {
                    [[NSFileManager defaultManager] createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
                }

                NSString *key = [MD5Encryption stringToMD5:urlString];
                NSURL *url = [NSURL URLWithString:urlString];
                NSString *toPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingFormat:@"/imageCache/%@.%@",key,url.pathExtension];
                
                JSValue *function = [self.context objectForKeyedSubscript:callback];
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:toPath]) {
                    [function callWithArguments:@[toPath]];
                    return;
                }
                
                HttpDownloader * downLoader = [[HttpDownloader alloc] init];
                [downLoader download:url completion:^(NSURL * location, NSError * error) {
                    
                    if (!error) {
                        
                        NSError *fileEror = nil;
                        [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:toPath error:&fileEror];
                        [function callWithArguments:@[toPath]];
                        
                    } else {
                        [function callWithArguments:nil];
                    }
                    
                } downloading:nil];
            }
        }
    }
}

/**
 分享
 
 @param jsonStr 分享json
 */
- (void)goNewsShare:(NSString *)jsonStr {
    
    NSDictionary *dic                   = [NSDictionary dictionaryWithJsonString:jsonStr];
  
}


- (void)share:(NSString *)title :(NSString *)msg :(NSString *)url :(NSString *)imgurl :(NSString *)shareId {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *dict   = [NSMutableDictionary dictionary];
        dict[@"title"]              = title;
        dict[@"conent"]             = msg;
        dict[@"link"]               = url;
        
      
        
    });
}

- (void)shareWithTitle:(NSString *)titleString message:(NSString *)msgString shareURL:(NSString *)shareURLString imgURL:(NSString *)imgURLString shareId: (NSString *)shareId {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请选择分享平台" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //获取app中所有icon名字数组
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    NSString *iconLastName = [iconsArr lastObject];
    OSMessage *msg = [[OSMessage alloc] init];
    // 微信
    if ([OpenShare isWeixinInstalled]) {
        UIAlertAction * friendAction = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            msg.title= titleString;
            msg.desc = msgString;
            msg.link = shareURLString;
            UIImage *testImage = [UIImage imageNamed:iconLastName];
            msg.image= UIImageJPEGRepresentation(testImage, 0.5f);
            
            // 微信会话
            [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
                
                [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"分享成功"];
                JSValue *function = [self.context objectForKeyedSubscript:@"shareCallback"];
                [function callWithArguments:[NSArray arrayWithObjects:shareId, nil]];
                
                XFLog(@"微信分享到会话成功：\n%@",message);
            } Fail:^(OSMessage *message, NSError *error) {
                XFLog(@"微信分享到会话失败：\n%@\n%@",error,message);
            }];
        }];
        [alertVC addAction:friendAction];
        
        UIAlertAction * timeLineAction = [UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            msg.title= titleString;
            msg.desc = msgString;
            msg.link = shareURLString;
            UIImage *testImage = [UIImage imageNamed:iconLastName];
            msg.image= UIImageJPEGRepresentation(testImage, 0.5f);
            
            // 微信朋友圈
            [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
                
                [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"分享成功"];
                JSValue *function = [self.context objectForKeyedSubscript:@"shareCallback"];
                [function callWithArguments:[NSArray arrayWithObjects:shareId, nil]];
                
                XFLog(@"微信分享到朋友圈成功：\n%@",message);
            } Fail:^(OSMessage *message, NSError *error) {
                XFLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
            }];
        }];
        [alertVC addAction:timeLineAction];
    }
    
    
    if (alertVC.actions.count) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:cancelAction];
        [self.viewController presentViewController:alertVC animated:YES completion:nil];
    } else {
        [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"您尚未安装社交软件"];
    }
}

- (void)callMeMaybeAction:(NSString *)phoneNumberString {
    
    NSMutableString *telString = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", phoneNumberString];
    [UIApplication.sharedApplication openURL:[NSURL URLWithString:telString]];
}

/**
 获取应用版本号
 *
 */
- (NSString *)getAppVersion {
    
    NSString *versionString = [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return versionString;
}

/**
 获取网络状态
 
 @return number
 */
- (int)getNetStatus {
    
    return [Utils getNetStatus];
}

/**
 运营商
 
 @return number
 */
- (int)getSimOperatorName {
    
    return [Utils serviceProvider];
}

/**
 获取设备机型
 
 */
- (NSString *)getPhoneModel {
    
    NSString *deviceVersionString = [Utils deviceVersion];
    return deviceVersionString;
}

/**
 获取设备操作系统版本

 */
- (NSString *)getOsVersion {
    
    NSString *systemVersionString = [NSString stringWithFormat:@"%.2f", [UIDevice.currentDevice.systemVersion floatValue]];
    return systemVersionString;
}

- (NSString *)getUserType {
    
    return @"ss";
}

- (void)goLoginPage {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.viewController presentViewController:nav animated:YES completion:nil];
}

/**
 去实名认证
 */
- (void)goRealNameCert {

   
}

/**
 机构认证
 */
- (void)goOrganizationCert {
    
   
}

- (void)goContactMyGuru {
    
 
}

- (void)goToLoans:(NSString *)loanType {
    
   
}

- (void)checkSubType:(NSString *)loanType {
    
    
}
@end
