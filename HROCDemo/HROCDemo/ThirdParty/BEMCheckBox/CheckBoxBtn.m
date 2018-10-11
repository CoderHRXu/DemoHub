//
//  CheckBoxBtn.m
//  lewei
//
//  Created by xuhaoran on 16/8/17.
//  Copyright © 2016年 Sunfit. All rights reserved.
//

#import "CheckBoxBtn.h"

@implementation CheckBoxBtn

- (instancetype)init{
    self = [super init];
    if (self) {
        self.onTintColor        = kGlobalTintColor;
        self.onFillColor        = kGlobalTintColor;
        self.onCheckColor       = [UIColor whiteColor];
        self.lineWidth          = 1.0;
        self.boxType            = BEMBoxTypeSquare;
        self.onAnimationType    = BEMAnimationTypeFill;
        self.offAnimationType   = BEMAnimationTypeFill;
        self.tintColor          = [UIColor colorWithHexString:@"F4F4F4"];
    }
    return self;
}



-(void)awakeFromNib{
    [super awakeFromNib];
    self.onTintColor        = kGlobalTintColor;
    self.onFillColor        = kGlobalTintColor;
    self.onCheckColor       = [UIColor whiteColor];
    self.lineWidth          = 1.0;
    self.boxType            = BEMBoxTypeSquare;
    self.onAnimationType    = BEMAnimationTypeFill;
    self.offAnimationType   = BEMAnimationTypeFill;
    self.tintColor          = [UIColor colorWithHexString:@"F4F4F4"];
}
@end
