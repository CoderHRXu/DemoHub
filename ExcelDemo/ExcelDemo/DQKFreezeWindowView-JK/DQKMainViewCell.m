//
//  DQKMainViewCell.m
//  DQKFreezeWindowView
//
//  Created by 宋宋 on 15/7/15.
//  Copyright © 2015年 dianqk. All rights reserved.
//

#import "DQKMainViewCell.h"

@interface DQKMainViewCell ()
{
    CGSize _textSize;
}
@property (strong, nonatomic) UIView *leftLine;
@property (strong, nonatomic) UIView *rightLine;
@property (strong, nonatomic) UIView *topLine;
@property (strong, nonatomic) UIView *bottomLine;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *titleButton;

@property (strong, nonatomic) UIImageView *titleImage;
@property (strong, nonatomic) UIImage *maxImage;
@property (strong, nonatomic) UIImage *minImage;


@end

@implementation DQKMainViewCell

- (instancetype)initWithStyle:(DQKMainViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    if (self) {
        _reuseIdentifier                    = reuseIdentifier;
        _rowNumber                          = 1;
        _sectionNumber                      = 1;
        [self addLine];
        switch (style) {
            case DQKMainViewCellStyleDefault:
            {
                _style                      = style;
                _titleLabel                 = [[UILabel alloc] init];
                _titleLabel.textAlignment   = NSTextAlignmentCenter;
                _titleLabel.lineBreakMode   = NSLineBreakByTruncatingHead;
                [self addSubview:_titleLabel];
            }
                break;
            case DQKMainViewCellStyleJKTeacher:{
                _style = style;

                _titleLabel                 = [[UILabel alloc] init];
                _titleLabel.font            = [UIFont systemFontOfSize:17.0f];
                _titleLabel.textAlignment   = NSTextAlignmentCenter;
                _titleLabel.lineBreakMode   = NSLineBreakByTruncatingHead;
                [self addSubview:_titleLabel];

                
            }
                break;
            case DQKMainViewCellStyleCustom:
            {
                _style                      = style;
            }
                break;
            default:
                break;
        }
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    switch (_style) {
        case DQKMainViewCellStyleDefault:
        {
            self.titleLabel.text = title;
        }
            break;
        case DQKMainViewCellStyleJKTeacher:
        {
            NSDictionary* attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17.0f]};
            _textSize = [title  sizeWithAttributes:attributes];
            self.titleLabel.text= title;
        }
            break;
        default:
            break;
    }
}



- (void)setScroreStyle:(DQKMainViewCellScoreStyle)scroreStyle{
    _scroreStyle = scroreStyle;
    switch (scroreStyle) {
        case DQKMainViewCellScoreStyleMax:{

            _titleImage         = [[UIImageView alloc] init];
            _titleImage.image   = [UIImage imageNamed:@"imageMax"];
            [self addSubview:_titleImage];
        }
            break;
        case DQKMainViewCellScoreStyleMin:{
            
            _titleImage         = [[UIImageView alloc] init];
            _titleImage.image   = [UIImage imageNamed:@"imageMin"];
            [self addSubview:_titleImage];
        }
            break;
            
        default:
            break;
    }
}

- (void)setSeparatorStyle:(DQKMainViewCellSeparatorStyle)separatorStyle {
    _separatorStyle = separatorStyle;
    if (separatorStyle == DQKMainViewCellSeparatorStyleNone) {
        [self removeLine];
    }
}

- (void)addLine {
    
    UIColor *lineGrayColor      = [UIColor colorWithRed:205./255. green:205./255. blue:205./255. alpha:1];
    _leftLine                   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.frame.size.height)];
    _leftLine.backgroundColor   = lineGrayColor;
    [self addSubview:_leftLine];
    
    _rightLine                  = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, 0.5, self.frame.size.height)];
    _rightLine.backgroundColor  = lineGrayColor;
    [self addSubview:_rightLine];
    
    _topLine                    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    _topLine.backgroundColor    = lineGrayColor;
    [self addSubview:_topLine];
    
    
    _bottomLine                 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.5)];
    _bottomLine.backgroundColor = lineGrayColor;
    [self addSubview:_bottomLine];
}

- (void)removeLine {
    [self.leftLine removeFromSuperview];
    [self.rightLine removeFromSuperview];
    [self.topLine removeFromSuperview];
    [self.bottomLine removeFromSuperview];
}

- (void)setLine {
    [self.leftLine setFrame:CGRectMake(0, 0, 0.5, self.frame.size.height)];
    [self.rightLine setFrame:CGRectMake(self.frame.size.width, 0, 0.5, self.frame.size.height)];
    [self.topLine setFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    [self.bottomLine setFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.5)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.style == DQKMainViewCellStyleDefault ) {
        [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    if (self.separatorStyle == DQKMainViewCellSeparatorStyleSingleLine) {
        [self setLine];
    }
    if (self.style == DQKMainViewCellStyleJKTeacher ) {
        [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titleImage.frame = CGRectMake(self.bounds.size.width/2+_textSize.width/2+5, (self.bounds.size.height-20)/2, 50, 20);

    }
}

//- (UIImage*)scaleToSize:(CGSize)size image:(UIImage*)image
//{
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    //Determine whether the screen is retina
//    if([[UIScreen mainScreen] scale] == 2.0){
//        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
//    }else{
//        UIGraphicsBeginImageContext(size);
//    }
//    // 绘制改变大小的图片
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    // 返回新的改变大小后的图片
//    return scaledImage;
//}

@end
