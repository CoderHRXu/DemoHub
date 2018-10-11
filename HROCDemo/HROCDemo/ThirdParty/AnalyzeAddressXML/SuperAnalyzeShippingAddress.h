//
//  SuperAnalyzeShippingAddress.h
//  MoboApp
//
//  Created by mac on 12-12-25.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperAnalyzeShippingAddress : NSObject<NSXMLParserDelegate>
{
    NSMutableArray *shippingAddressArray;
    BOOL isAnalyzed;                                    //判断是否解析完成
    NSString *fileName;                                 //要解析的文件名称
}
@property(nonatomic,strong)NSMutableArray *shippingAddressArray;
@property(nonatomic,assign)BOOL isAnalyzed;
- (void)startAnalyze;
@end
