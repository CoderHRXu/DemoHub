//
//  FCBaseDataModel.h
//  MCVVM-iOS
//
//  Created by 邹时新 on 2017/12/11.
//  Copyright © 2017年 zoushixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCBaseDataModel : NSObject

/** 错误代码 */
@property (nonatomic, assign) NSInteger error_code;
/** 错误消息 */
@property (nonatomic, copy) NSString *error_msg;
/** 是否成功 */
@property (nonatomic, assign) BOOL isSuccess;

/**
 接口字典转模型

 @param response 接口返回值
 @return 模型数据
 */
+ (instancetype)fc_modelWithResponse:(NSDictionary *)response;

@end
