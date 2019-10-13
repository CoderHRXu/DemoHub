//
//  FeedBackSenceSectionHeader.m
//  HROCDemo
//
//  Created by haoran on 2019/8/4.
//  Copyright © 2019 Sunfit. All rights reserved.
//

#import "FeedBackSenceSectionHeader.h"
#import <Masonry/Masonry.h>


@interface FeedBackSenceSectionHeader ()

/** 组名  */
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation FeedBackSenceSectionHeader

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}



- (void)setupUI {
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.centerY.equalTo(self);
    }];
}

#pragma mark - Getter && Setter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 16];
        _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _nameLabel;
}

- (void)setGroupName:(NSString *)groupName {
    _groupName = groupName;
    self.nameLabel.text = groupName;
}
@end
