//
//  DQKRowViewCell.m
//  DQKFreezeWindowView
//
//  Created by 宋宋 on 15/7/15.
//  Copyright © 2015年 dianqk. All rights reserved.
//

#import "DQKRowViewCell.h"


@interface DQKRowViewCell ()
@property (strong, nonatomic) UIView  *topLine;
@property (strong, nonatomic) UIView  *bottomLine;
@property (strong, nonatomic) UIView  *middleLine;
@property (strong, nonatomic) UIView  *rightLine;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *secondLabel;
@end

@implementation DQKRowViewCell

- (instancetype)initWithStyle:(DQKRowViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    if (self) {
        _reuseIdentifier                    = reuseIdentifier;
        switch (style) {
            case DQKRowViewCellStyleDefault:
            {
                _style                      = style;
                _titleLabel                 = [[UILabel alloc] init];
                _titleLabel.textAlignment   = NSTextAlignmentLeft;
                _titleLabel.lineBreakMode   = NSLineBreakByTruncatingHead;
                [self addSubview:_titleLabel];
            }
                break;
            case DQKRowViewCellStyleJKTeacher:{
                _style                      = style;
                _titleLabel                 = [[UILabel alloc] init];
                _titleLabel.textAlignment   = NSTextAlignmentCenter;
                _titleLabel.lineBreakMode   = NSLineBreakByTruncatingHead;
                [self addSubview:_titleLabel];
            }
                break;
            case DQKRowViewCellStyleJKTeacherTwoSection:{
                _style                      = style;
                _titleLabel                 = [[UILabel alloc] init];
                _titleLabel.textAlignment   = NSTextAlignmentCenter;
                _titleLabel.lineBreakMode   = NSLineBreakByTruncatingHead;
                _secondLabel                = [[UILabel alloc] init];
                _secondLabel.textAlignment  = NSTextAlignmentCenter;
                _secondLabel.lineBreakMode  = NSLineBreakByTruncatingHead;
                [self addSubview:_titleLabel];
                [self addSubview:_secondLabel];
            }
                break;
            case DQKRowViewCellStyleCustom:
            {
                _style                      = style;
            }
                break;
            default:
                break;
        }
    }
    [self addLine];
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    switch (_style) {
        case DQKRowViewCellStyleDefault:
        {
            self.titleLabel.text = title;
        }
            break;
        case DQKRowViewCellStyleJKTeacher:
        {
            if ([_title containsString:@"("]) {
                
                NSArray *array                          = [_title componentsSeparatedByString:@"("];
                NSString *string0                       = array[0];
                NSMutableString *string1                = [[NSMutableString alloc] initWithString:array[1]];
                [string1 insertString:@"(" atIndex:0];
                NSMutableAttributedString *attrString   = [[NSMutableAttributedString alloc] initWithString:_title];
                UIFont *baseFont                        = [UIFont systemFontOfSize:16];
                [attrString addAttribute:NSFontAttributeName value:baseFont range:[_title rangeOfString:string0]];
                UIFont *boldFont                        = [UIFont boldSystemFontOfSize:14];
                [attrString addAttribute:NSFontAttributeName value:boldFont range:[_title rangeOfString:string1]];
                [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[_title rangeOfString:string0]];
                [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[_title rangeOfString:string1]];
                self.titleLabel.attributedText          = attrString;
            }else{
                self.titleLabel.text                    = title;
                self.titleLabel.font                    = [UIFont systemFontOfSize:16];
            }
        }
            break;
            
        case DQKRowViewCellStyleJKTeacherTwoSection:{
            self.titleLabel.text                        = title;
            self.titleLabel.font                        = [UIFont systemFontOfSize:16];
        }
            break;
            
        default:
            break;
    }
}

- (void)setSecondTitle:(NSString *)secondTitle{
    if (_style == DQKRowViewCellStyleJKTeacherTwoSection) {
        self.secondLabel.text = secondTitle;
        self.secondLabel.font = [UIFont systemFontOfSize:16];
    }
}

- (void)setSeparatorStyle:(DQKRowViewCellSeparatorStyle)separatorStyle {
    _separatorStyle = separatorStyle;
    if (separatorStyle == DQKRowViewCellSeparatorStyleNone) {
        [self removeLine];
    }
}

- (void)addLine {
    
    UIColor *lineGrayColor                              = [UIColor colorWithRed:205./255. green:205./255. blue:205./255. alpha:1];
    _topLine                                            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    _topLine.backgroundColor                            = lineGrayColor;
    [self addSubview:_topLine];
    _bottomLine                                         = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.5)];
    _bottomLine.backgroundColor                         = lineGrayColor;
    [self addSubview:_bottomLine];
    _rightLine                                          = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 0.5, 0, 0.5, self.frame.size.height)];
    _rightLine.backgroundColor                          = lineGrayColor;
    [self addSubview:_rightLine];
    if (_style == DQKRowViewCellStyleJKTeacherTwoSection) {
        _middleLine                                     = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0 , 0.5, self.frame.size.height)];
        _middleLine.backgroundColor                     = lineGrayColor;
        [self addSubview:_middleLine];
    }
}

- (void)removeLine {
    
    [self.topLine removeFromSuperview];
    [self.bottomLine removeFromSuperview];
    [self.rightLine removeFromSuperview];
}

- (void)setLine {
    
    [self.topLine setFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    [self.bottomLine setFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.5)];
    [self.rightLine setFrame:CGRectMake(self.frame.size.width - 0.5, 0, 0.5, self.frame.size.height)];
    if (_style == DQKRowViewCellStyleJKTeacherTwoSection) {
        [self.middleLine setFrame:CGRectMake(self.frame.size.width/2, 0 , 0.5, self.frame.size.height)];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.style == DQKRowViewCellStyleDefault) {
        [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    if (self.separatorStyle == DQKRowViewCellSeparatorStyleSingleLine) {
        [self setLine];
    }
    if (self.style == DQKRowViewCellStyleJKTeacher) {
        [self.titleLabel setFrame:CGRectMake(5, 0, self.frame.size.width - 10, self.frame.size.height)];
    }
    if (self.style == DQKRowViewCellStyleJKTeacherTwoSection) {
        [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height)];
        [self.secondLabel setFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height)];
    }
    
}

@end
