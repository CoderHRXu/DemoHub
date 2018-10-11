//
//  DownloadH5ZipRequest.h
//  XiangFa
//
//  Created by PandaApe on 13/03/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import "BaseRequest.h"

@interface DownloadH5ZipRequest : BaseRequest

@property (strong, nonatomic) NSString *downloadUrl;

@property (strong, nonatomic) NSString *filePath;

@end
