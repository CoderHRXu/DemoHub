//
//  Utils.m
//  XiangFa
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn) on 09/02/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import "Utils.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "Reachability.h"

@implementation Utils

+ (NSString*)deviceVersion {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad 1G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini 1G";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini 1G";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini 1G";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
    if ([deviceString isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    
    return deviceString;
}

/**
 获取网络状态 0=无网络, 1=WIFI, 2=2G, 3=3G, 4=4G, -1=不可识别的网络
 
 @return number
 */
+ (int)getNetStatus {
    
    NSString *stateString = nil;
    int netStatusNumber = 0;

    switch ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]) {
            
        case NotReachable: {
            
            stateString = @"无网络";
            netStatusNumber = 0;
        }
            break;
        case kReachableVia2G: {
            
            stateString = @"2G";
            netStatusNumber = 2;
        }
            break;
        case kReachableVia3G: {
         
            stateString = @"3G";
            netStatusNumber = 3;
        }
            break;
        case kReachableVia4G: {
            
            stateString = @"4G";
            netStatusNumber = 4;
        }
            break;
        case ReachableViaWiFi: {
            
            stateString = @"WIFI";
            netStatusNumber = 1;
        }
            break;
        default: {
            
            stateString = @"不可识别的网络";
            netStatusNumber = -1;
        }
            break;
    }
    return netStatusNumber;
}

/**
 网络运营商类型 1中国移动 2中国电信 3中国联通 4其他
 
 @return
 */
+ (int)serviceProvider {
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    
    int serviceProviderNumber = 0;
    if ([carrier.carrierName isEqualToString:@"中国移动"]) {
        
        serviceProviderNumber = 1;
    } else if ([carrier.carrierName isEqualToString:@"中国电信"]) {
        
        serviceProviderNumber = 2;
    } else if ([carrier.carrierName isEqualToString:@"中国联通"]) {
        
        serviceProviderNumber = 3;
    } else {
        
        serviceProviderNumber = 4;
    }
    return serviceProviderNumber;
}

+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month
{
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year%400==0 || (year%100!=0 && year%4 == 0)) {
                return 29;
            }else{
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}

+ (NSData *)compressImage:(UIImage *)image {
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    if (imageData.length <= 1000*1000) {
        
        return imageData;
    } else if (imageData.length > 1000*1000 && imageData.length < 3000 * 1000) {
        
        imageData = UIImageJPEGRepresentation(image, 0.8f);
        return imageData;
    } else if (imageData.length > 3000*1000 && imageData.length < 5000 * 1000) {
        
        imageData = UIImageJPEGRepresentation(image, 0.6f);
        return imageData;
    } else {
        
        imageData = UIImageJPEGRepresentation(image, 0.4f);
        return imageData;
    }
}
@end
