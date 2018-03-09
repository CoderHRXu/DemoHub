//
//  AppDelegate.m
//  QIYUDemo
//
//  Created by haoran on 2018/3/8.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

#import "AppDelegate.h"
#import <QIYU_iOS_SDK/QYSDK.h>
#import <UserNotifications/UserNotifications.h>

#define QiYuAppKey  @"2268c1d5ca456c4cda47a9ff6d3b8fe3"

@interface AppDelegate ()<QYConversationManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self configQIYU];
    [self regesiterPushNotification];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[QYSDK sharedSDK] updateApnsToken:deviceToken];
    NSLog(@"devicetoken -- %@",deviceToken);
}



#pragma mark - PrivateMethod
- (void)configQIYU {
    
    [[QYSDK sharedSDK] registerAppId:QiYuAppKey appName:@"教师Beta"];
    // 代理&监听
    [[QYSDK sharedSDK].conversationManager setDelegate:self];
}

- (void)regesiterPushNotification {
    //iOS10必须加下面这段代码。
   
    //注册 APNS
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]){
        
        UIUserNotificationType types            = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        UIUserNotificationSettings *settings    = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
        
        UIRemoteNotificationType types      = UIRemoteNotificationTypeAlert
        | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
    
    NSLog(@"收到推送通知");
  
}
#pragma mark - QYConversationManagerDelegate
/**
 *  会话未读数变化
 *
 *  @param count 未读数
 */
- (void)onUnreadCountChanged:(NSInteger)count{
    
    NSLog(@"会话未读数变化🐶 ---- %zd",count);
}


/**
 *  收到消息
 */
- (void)onReceiveMessage:(QYMessageInfo *)message{
    
    NSLog(@"收到消息----\n%@",message.text);
}

@end
