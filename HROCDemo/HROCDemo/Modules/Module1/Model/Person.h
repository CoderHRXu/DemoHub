//
//  Person.h
//  HROCDemo
//
//  Created by haoran on 2018/10/30.
//  Copyright © 2018年 Sunfit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithID:(NSInteger)uid name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
