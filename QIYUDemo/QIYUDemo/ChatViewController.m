//
//  ChatViewController.m
//  QIYUDemo
//
//  Created by haoran on 2018/3/8.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (instancetype)init
{
    self = [[QYSDK sharedSDK] sessionViewController];
    if (self) {
        QYSource *source    = [[QYSource alloc] init];
        source.title        =  @"专属客服233";
        source.urlString    = @"http://www.fclassroom.com/";
        self.sessionTitle   = @"专属客服233";
        self.source         = source;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onBack:)];
        
        // 样式修改
        QYCustomUIConfig *uiCofig = [QYCustomUIConfig sharedInstance];
        uiCofig.customerHeadImageUrl = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2447967976,2775617709&fm=58&w=121&h=121&img.JPEG&bpow=512&bpoh=512";
        [[QYSDK sharedSDK] customUIConfig].sessionTipTextColor = [UIColor redColor];
        
      
        UIImageView *imageView       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kakaxi"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [[QYSDK sharedSDK] customUIConfig].sessionBackground = imageView;

        
        // 用户信息
        QYUserInfo *userInfo                        = [[QYUserInfo alloc] init];
        userInfo.userId                             = @"userId";
        NSMutableArray *array                       = [NSMutableArray new];
        NSMutableDictionary *dictRealName           = [NSMutableDictionary new];
        dictRealName[@"key"]                        = @"real_name";
        dictRealName[@"value"]                      = @"么么哒";
        [array addObject:dictRealName];
        
        NSMutableDictionary *dictMobilePhone        = [NSMutableDictionary new];
        [dictMobilePhone setObject:@"mobile_phone" forKey:@"key"];
        [dictMobilePhone setObject:@"13805713536" forKey:@"value"];
        [dictMobilePhone setObject:@(NO) forKey:@"hidden"];
        dictMobilePhone[@"hidden"] = @(NO);
        [array addObject:dictMobilePhone];
        
        NSMutableDictionary *dictEmail              = [NSMutableDictionary new];
        [dictEmail setObject:@"email" forKey:@"key"];
        [dictEmail setObject:@"bianchen@163.com" forKey:@"value"];
//        [array addObject:dictEmail];
        
        NSMutableDictionary *dictAuthentication     = [NSMutableDictionary new];
        [dictAuthentication setObject:@"0" forKey:@"index"];
        [dictAuthentication setObject:@"schoolName" forKey:@"key"];
        [dictAuthentication setObject:@"学校名称" forKey:@"label"];
        [dictAuthentication setObject:@"星海实验小学" forKey:@"value"];
        [array addObject:dictAuthentication];
        
        NSMutableDictionary *dictBankcard           = [NSMutableDictionary new];
        [dictBankcard setObject:@"1" forKey:@"index"];
        [dictBankcard setObject:@"bankcard" forKey:@"key"];
        [dictBankcard setObject:@"绑定银行卡" forKey:@"label"];
        [dictBankcard setObject:@"622202******01116068" forKey:@"value"];
//        [array addObject:dictBankcard];
        
        NSData *data                                = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
        if (data){
            userInfo.data = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        [[QYSDK sharedSDK] setUserInfo:userInfo];
        
        
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)onBack:(id)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
