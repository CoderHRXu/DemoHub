//
//  Constants.m
//  HROCDemo
//
//  Created by Jeremy Pan on 16/7/15.
//  Copyright © 2016年 RJS. All rights reserved.
//

#import "Constants.h"

@implementation Constants

+ (NSString *)basePath {
    static NSString * path;
        
#if  (DEBUG&&SIT) 
    path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/wx2"];
#elif  (RELEASE&&SIT) 
    path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/wx2"];
#elif  (DEBUG&&UAT) 
    path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/wx2"];
#elif  (RELEASE&&UAT) 
    path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/wx2"];
#elif (DEBUG&&PRO)
    path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/wx2"];
#else
    path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/wx2"];
#endif
    return path;
}
@end
