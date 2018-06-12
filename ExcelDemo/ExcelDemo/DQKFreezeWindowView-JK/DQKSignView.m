//
//  DQKFreezeView.m
//  DQKFreezeWindowView
//
//  Created by 宋宋 on 15/7/15.
//  Copyright © 2015年 dianqk. All rights reserved.
//

#import "DQKSignView.h"

@interface DQKSignView ()

@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *secondLabel;
@property (strong, nonatomic) UIView  *middleLine;
@property (strong, nonatomic) UIView  *bottomLine;
@property (strong, nonatomic) UIView  *rightLine;
@end

@implementation DQKSignView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *lineGrayColor = [UIColor colorWithRed:205./255. green:205./255. blue:205./255. alpha:1];
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/4, self.frame.size.width, frame.size.height / 2)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:16];

        [self addSubview:_contentLabel];
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height)];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_secondLabel];
        
        _middleLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0, 0.5, self.frame.size.height)];
        _middleLine.backgroundColor = lineGrayColor;
        [self addSubview:_middleLine];
        
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0,self.frame.size.height, self.frame.size.width, 0.5)];
        _bottomLine.backgroundColor = lineGrayColor;
        [self addSubview:_bottomLine];
        
        _rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 0.5,0, 0.5, self.frame.size.height)];
        _rightLine.backgroundColor = lineGrayColor;
        [self addSubview:_rightLine];
        
    }
    return self;
}

- (void)setContent:(NSString *)content SecondContent:(NSString *)seContent DQKSignViewStyle:(DQKSignViewStyle)style{
    switch (style) {
        case DQKSignViewStyleDefault:
        {
            self.contentLabel.text = content;
            _contentLabel.frame = CGRectMake(0, self.frame.size.height/4, self.frame.size.width, self.frame.size.height / 2);
            [_secondLabel removeFromSuperview];
            [_middleLine removeFromSuperview];
        }
            break;
        case DQKSignViewStyleTwoSection:
        {
            _contentLabel.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
            self.contentLabel.text = content;
            self.secondLabel.text = seContent;
            [self addSubview:_secondLabel];
            [self addSubview:_middleLine];
            
        }
            break;
            
        default:
            break;
    }
}


@end
