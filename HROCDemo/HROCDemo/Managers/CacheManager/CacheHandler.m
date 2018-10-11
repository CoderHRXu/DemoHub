//
//  CacheHandler.m
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 05/02/2017.
//  Copyright © 2017 RJS. All rights reserved.
//

#import "CacheHandler.h"

@implementation CacheHandler

+ (instancetype) sharedHandler {

    static CacheHandler* handler = nil;
    static dispatch_once_t onceToken;
    
    
    dispatch_once(&onceToken, ^{
        
        handler = [[CacheHandler alloc]init];
    });
    
    return handler;
}

- (BOOL)userLoggedin {
//
//    if (self.currentUser) {
//
//        return self.currentUser.loggedIn;
//    } else {
//
//        return NO;
//    }
    return NO;
}


- (void)resetCache {
    
    [NSUserDefaults.standardUserDefaults removeObjectForKey:@"SessionToken"];
    [NSHTTPCookie removeCookie:@"session_token_dd" domain:@".^filecookies^"];
    [NSHTTPCookie removeCookie:@"session_token_dd" domain:CookieDomain];

//    self.currentUser.loggedIn   = NO;
//    self.currentUser.platformAuthInfo = nil;
//    self.currentUser.realNameAuthInfo = nil;
//
//
//    SaveChangesToDB;
//
//    self.currentLoan            = nil;
//    self.currentUser            = nil;
//    self.lockLoanId             = nil;
//    self.currentCustomer        = nil;
    NSLog(@"CacheHandler Has Been Reset.");
}


/**
 删除所有正式单
 */
- (void)deleteAllFormalLoan {
    
    
}
@end
