//
//  AddressDataManager.m
//  Dingdong
//
//  Created by Jeremy on 2016/10/28.
//  Copyright © 2016年 RJS. All rights reserved.
//

#import "AddressDataManager.h"
#import "ProvinceAnalyze.h"
#import "CityAnalyze.h"
@interface AddressDataManager ()

@property (nonatomic, strong) ProvinceAnalyze *provinceAnalyze;
@property (strong)NSMutableArray *formCituDataArray;
@property (nonatomic, assign) NSInteger indexRow;
@property (nonatomic, assign) NSInteger indexItem;

@end

@implementation AddressDataManager
+ (instancetype)shareInstance {
    static AddressDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AddressDataManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        
        _formCituDataArray = [NSMutableArray alloc];
    }
    return self;
}

- (void)setAddress:(NSInteger)cityId {
    
    _indexRow = 0;
    _indexItem = 0;
    BOOL haved = NO;
    
    for (int i = 0; i < _provinceAnalyze.shippingAddressArray.count; i++) {
        
        NSDictionary *tempDictionary = [_provinceAnalyze.shippingAddressArray objectAtIndex:i];
        CityAnalyze *tempCityAnalyze = [[CityAnalyze alloc] init];
        [tempCityAnalyze startAnalyze:[tempDictionary valueForKey:@"ID"]];
        [_formCituDataArray addObject:tempCityAnalyze.shippingAddressArray];
        
        if (cityId > 0) {
            
            if (!haved) {
                
                for (int j = 0; j < tempCityAnalyze.shippingAddressArray.count; j++) {
                    
                    if ([[[tempCityAnalyze.shippingAddressArray objectAtIndex:j] valueForKey:@"ID"] integerValue] == cityId) {
                        
                        _indexRow = i;
                        _indexItem = j;
                        haved = YES;
                        break;
                    }
                }
            }
        }
    }
}


@end
