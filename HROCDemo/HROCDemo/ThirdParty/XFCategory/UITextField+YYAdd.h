//
//  UITextField+YYAdd.h
//  XiangFa
//
//  Created by WeiWei on 17/2/17.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YYAdd)

/**
 Set text in range selected.
 
 @param range  The range of selected text in a document.
 */
- (void)setSelectedRange:(NSRange)range;

@end
