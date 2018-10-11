//
//  CityAnalyze.h
//  MoboApp
//
//  Created by mac on 12-12-25.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import "SuperAnalyzeShippingAddress.h"

@interface CityAnalyze : SuperAnalyzeShippingAddress
{
    NSString *pId;                  //所属省份的ID
}
- (void)startAnalyze:(NSString*)_pId;
@end
