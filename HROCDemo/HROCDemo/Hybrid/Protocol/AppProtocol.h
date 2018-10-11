//
//  WebAppProtocol.h
//  HROCDemo
//
//  Created by clubo on 16/3/17.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
/**
 *  webApp协议
 */
@protocol AppProtocol <JSExport>
/**
 *  回到首页
 */
- (void)toIndex:(NSString *)options;

/**
 返回根页面
 */
- (void)toRoot;


/**
  *  后退

 @param url
 @param isHome
 */
-(void)go:(NSString *)url Back:(BOOL)isHome ;


/**
  *  前进

 @param options
 */
-(void)goToHref:(NSString *)options;

/**
  *  保存图片

 @param url
 */
-(void)saveImage:(NSString *)url;


/**
  *  设置标题

 @param options
 */
-(void)setTitleBar:(NSString *)options;


/**
  *  获取图片

 @param options 
 */
-(void)getImage:(NSString *)options;

/**
 拨打电话

 @param phoneNumberString 无格式及前缀的电话号码
 */
- (void)callMeMaybeAction:(NSString *)phoneNumberString;

/**
 获取应用版本号
 *
 */
- (NSString *)getAppVersion;

/**
 获取网络状态

 @return number
 */
- (int)getNetStatus;


/**
 运营商

 @return number
 */
- (int)getSimOperatorName;

/**
 获取设备机型


 */
- (NSString *)getPhoneModel;

/**
 获取设备操作系统版本

 */
- (NSString *)getOsVersion;

/**
 跳转登录页
 */
- (void)goLoginPage;


/**
 去实名认证
 */
- (void)goRealNameCert;

/**
 去机构认证
 */
- (void)goOrganizationCert;

/**
 获取用户类型

 */
- (NSString *)getUserType;

/**
 分享资讯

 @param jsonStr 分享json
 */
- (void)goNewsShare:(NSString *)jsonStr;

/**
 *  分享
 */
- (void)share:(NSString *)title :(NSString *)msg :(NSString *)url :(NSString *)imgurl :(NSString *)shareId;

/**
 额度预估去录单

 @param loanType 单子类型
 */
- (void)goToLoans:(NSString *)loanType;

/**
 联系达人，达人页
 */
- (void)goContactMyGuru;
@end


