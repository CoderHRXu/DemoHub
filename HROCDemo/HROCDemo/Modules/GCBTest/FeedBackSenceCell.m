//
//  FeedBackSenceCell.m
//  HROCDemo
//
//  Created by haoran on 2019/8/4.
//  Copyright © 2019 Sunfit. All rights reserved.
//

#import "FeedBackSenceCell.h"

@interface FeedBackSenceCell()

/** titleLabel  */
//@property (nonatomic, strong) UILabel *label;

@end


@implementation FeedBackSenceCell

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    self.label.frame            = self.bounds;
    [self addSubview:self.label];
    self.layer.masksToBounds    = YES;
    self.layer.borderWidth      = 1;
    self.layer.cornerRadius     = 2;
    self.layer.borderColor      = [UIColor colorWithHexString:@"E2E4E8"].CGColor;
    
}

#pragma mark - Getter && Setter
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:12];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
