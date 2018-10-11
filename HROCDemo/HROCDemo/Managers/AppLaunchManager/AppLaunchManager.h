//
//  AppLaunchManager.h
//  XiangFa
//
//  Created by PandaApe on 08/03/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppLaunchManager : NSObject


/**
 用来 管理APP启动时做的操作
 */
@property (strong, nonatomic) UIApplication *application;

+ (instancetype) manager;




@end
