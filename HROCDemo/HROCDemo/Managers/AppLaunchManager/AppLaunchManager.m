//
//  AppLaunchManager.m
//  XiangFa
//
//  Created by PandaApe on 08/03/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import "AppLaunchManager.h"

@implementation AppLaunchManager

+ (instancetype) manager {
    
    static AppLaunchManager* manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[AppLaunchManager alloc]init];
    });
    
    return manager;
}


@end
