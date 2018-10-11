//
//  XFAlertView.m
//  Dingdong
//
//  Created by Jeremy on 2016/11/22.
//  Copyright © 2016年 RJS. All rights reserved.
//

#import "XFAlertView.h"
#import <objc/runtime.h>
static char key;
@implementation XFAlertView

- (void)showAlertViewWithCompleteBlock:(CompleteBlock)block {
    
    if (block) {
        //这里用到了runtime中绑定对象，将这个block对象绑定alertview上
        objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY);
        self.delegate = self;
    }
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //拿到之前绑定的block对象
    CompleteBlock block = objc_getAssociatedObject(self, &key);
    //移除所有关联
    //objc_removeAssociatedObjects(self);
    if (block) {
        
        block(buttonIndex);
    }
    
    block = nil;
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    
    if (self.continueLiving) {
        return;
    } else {
        [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    }
}
@end
