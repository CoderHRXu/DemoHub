//
//  DistrictsAnalyze.h
//  MoboApp
//
//  Created by mac on 12-12-25.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import "SuperAnalyzeShippingAddress.h"

@interface DistrictsAnalyze : SuperAnalyzeShippingAddress
{
    NSString *cId;                      //所属城市的ID
}
- (void)startAnalyze:(NSString*)_cId;
@end
