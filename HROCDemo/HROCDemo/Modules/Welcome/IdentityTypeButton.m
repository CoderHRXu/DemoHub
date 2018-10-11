//
//  IdentityTypeButton.m
//  HROCDemo
//
//  Created by Jeremy on 2017/8/15.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "IdentityTypeButton.h"

@interface IdentityTypeButton ()

@property (nonatomic, strong) UIView *lineView;
@end

@implementation IdentityTypeButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.adjustsImageWhenHighlighted = NO;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor colorWithHexString:@"#E2E2E2"] CGColor];
    self.layer.cornerRadius = 30.0;
    
    [self.titleLabel sizeToFit];
    [self addSubview:self.centerImageView];
    [self addSubview:self.lineView];

    CGFloat width = self.frame.size.width;
    self.centerImageView.size = CGSizeMake(0.55 * width, 0.55 * width);
    self.centerImageView.center = CGPointMake(width / 2, 80);
    self.imageView.size = CGSizeMake(0.14 * width, 0.14 * width);

    CGFloat imageWidth = self.imageView.intrinsicContentSize.width;
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat imageViewCenterX = (width - imageWidth - labelWidth - 8) / 2 + imageWidth / 2;
    
    self.imageView.center = CGPointMake(imageViewCenterX, 180);
    self.titleLabel.center = CGPointMake(imageViewCenterX + labelWidth/2 + imageWidth/2 + 8, 180);
}

- (UIImageView *)centerImageView {
    
    if (!_centerImageView) {
        
        _centerImageView = [[UIImageView alloc] init];
    }
    return _centerImageView;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, self.frame.size.width, 1)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#E2E2E2"];
    }
    return _lineView;
}
@end
