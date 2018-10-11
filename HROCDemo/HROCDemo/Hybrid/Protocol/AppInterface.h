//
//  WebProtocol.h
//  HROCDemo
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppProtocol.h"

@interface AppInterface : NSObject<AppProtocol, UINavigationControllerDelegate>

///构造函数
- (AppInterface *)initWithController:(UIViewController *)controller context:(JSContext *)context;
@end
