//
//  1PxLineConstraint.m
//  XiangFa
//
//  Created by PandaApe on 14/03/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import "OnePxLineConstraint.h"

@implementation OnePxLineConstraint
- (void)awakeFromNib{
    [super awakeFromNib];
  
    self.constant = 1.0 / [UIScreen mainScreen].scale;

}
@end
