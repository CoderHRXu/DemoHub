//
//  LocationManager.m
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 06/02/2017.
//  Copyright © 2017 RJS. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager() <CLLocationManagerDelegate>


@property (strong, nonatomic) CLLocationManager *locationManager;

@property (copy, nonatomic) LocatedSuccessBlcok locatedSuccessBlcok;

@end


@implementation LocationManager


- (instancetype)init {
    
    self = [super init];
    
    [self startUpdateLocation];
    return self;
}

- (void)startUpdateLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self; // 设置代理
    // 设置定位距离过滤参数 (当本次定位和上次定位之间的距离大于或等于这个值时，调用代理方法)
    self.locationManager.distanceFilter = 100;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 设置定位精度(精度越高越耗电)
    [self.locationManager requestWhenInUseAuthorization];
    

}

/** 获取到新的位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = locations.firstObject;
    
    NSString *locationStr = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    
    
    if ( self.locatedSuccessBlcok) {
        
        self.locatedSuccessBlcok(locationStr);
    }

    self.locatedSuccessBlcok = nil;
    
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"定位到了");
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading{
        NSLog(@"didUpdateHeading");
}
/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"获取定位失败");
}

- (void)startLocation:(LocatedSuccessBlcok) locatedSuccessBlcok {
    
    self.locatedSuccessBlcok = locatedSuccessBlcok;
    [self.locationManager startUpdatingLocation]; // 开始更新位置
 
}

+ (BOOL)hasLocationPermission {
    
    return !([CLLocationManager locationServicesEnabled] == NO || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied);
}

- (void)dealloc{
   
    NSLog(@"被释放");

}

@end
