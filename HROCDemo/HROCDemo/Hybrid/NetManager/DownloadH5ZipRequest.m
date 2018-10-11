//
//  DownloadH5ZipRequest.m
//  XiangFa
//
//  Created by PandaApe on 13/03/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import "DownloadH5ZipRequest.h"

@implementation DownloadH5ZipRequest

- (NSString *)requestUrl {
    
    return self.downloadUrl;
}

- (id)requestArgument{
    
    return nil;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return nil;
}

- (NSString *)resumableDownloadPath {
    
    NSString *libPath   = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *h5PackagePath = [libPath stringByAppendingPathComponent:@"H5Package"];
    NSString *filePath  = [libPath stringByAppendingPathComponent:@"h5.zip"];
    self.filePath       = filePath;
    
    return filePath;
}

- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodGET;
}

- (YTKResponseSerializerType)responseSerializerType {
    
    return YTKResponseSerializerTypeHTTP;
}

@end
