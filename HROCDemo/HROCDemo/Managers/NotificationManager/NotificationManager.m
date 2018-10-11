//
//  NotificationManager.m
//  XiangFa
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn) on 09/02/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import "NotificationManager.h"

@implementation NotificationManager

+ (void)postWithName:(NSString *)name object:(id)anObject {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:anObject];
    NSLog(@"%@ Notification Has Been Posted.",name);
}

+ (void)addObsrever:(id)observer selector:(SEL)aSelector name:(NSString *)aName {
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:nil];
    NSLog(@"%@ Notification Has Been Obsrevered By %@.", aName, observer);
}

+ (void)removeObserver:(id)observer {
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}


@end
