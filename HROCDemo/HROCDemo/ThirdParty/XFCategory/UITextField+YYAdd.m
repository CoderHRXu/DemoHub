//
//  UITextField+YYAdd.m
//  XiangFa
//
//  Created by WeiWei on 17/2/17.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "UITextField+YYAdd.h"

@implementation UITextField (YYAdd)

- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end
