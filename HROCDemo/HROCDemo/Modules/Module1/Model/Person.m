//
//  Person.m
//  HROCDemo
//
//  Created by haoran on 2018/10/30.
//  Copyright © 2018年 Sunfit. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithID:(NSInteger)uid name:(NSString *)name{
    if (self = [super init]) {
        self.uid = uid;
        self.name = name;
    }
    return self;
}

- (BOOL)isEqual:(Person *)object{
    BOOL result;
    if (self == object) {
        result = YES;
    }else{
        if (object.uid == self.uid) {
            result = YES;
        }else{
            result = NO;
        }
    }
    NSLog(@"%@ compare with %@ result = %@",self,object,result ? @"Equal":@"NO Equal");
    return result;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%p(%ld,%@)",self,self.uid,self.name];
}

- (NSUInteger)hash{
    NSUInteger hashValue = self.uid;
    //在这里只需要比较uid就行。这
//    样的话就满足如果两个实例相等，那么他们的 hash 一定相等，但反过
//    来hash值相等，那么两个实例不一定相等。但是在 Person 这个实例
//    中，hash值相等那么实例一定相等。（不考虑继承之类的）
    NSLog(@"hash = %lu,addressValue = %lu,address = %p",(NSUInteger)hashValue,(NSUInteger)self,self);
    return hashValue;
}

@end
