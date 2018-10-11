//
//  GetAppOnlineInfoRequest.m
//  XiangFa
//
//  Created by xuhaoran on 2017/7/18.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "GetAppOnlineInfoRequest.h"

@implementation GetAppOnlineInfoRequest

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return @{};
}

- (BOOL)showHUD {
    return NO;
}

- (BOOL)useCache {
    return NO;
}

- (NSString *)requestUrl{
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",APP_ID];
    return url;
}

- (id)requestArgument {
    return nil;
}

- (void)requestFinished:(BaseRequest *)request {

//    NSLog(@"\nResponse:  %@ -->%@", NSStringFromClass([self class]), self.responseString);

    NSDictionary *appData       = (NSDictionary*)self.responseObject;
    NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
    
    if ([versionsInAppStore count]) {
        
        NSString *currentAppStoreVersion    = [versionsInAppStore objectAtIndex:0];
        NSDictionary *infoDictionary        = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version               = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        self.isLarger                       = [app_Version compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedDescending;
    }
    
    [self requestSucceedPreprocessor];
    if (self.successBlock) {
        self.successBlock(request);
    }
}


@end
