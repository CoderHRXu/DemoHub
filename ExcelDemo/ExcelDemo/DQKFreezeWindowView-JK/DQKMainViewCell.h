//
//  DQKMainViewCell.h
//  DQKFreezeWindowView
//
//  Created by 宋宋 on 15/7/15.
//  Copyright © 2015年 dianqk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DQKMainViewCellStyle) {
    DQKMainViewCellStyleDefault,
    DQKMainViewCellStyleCustom,
    DQKMainViewCellStyleJKTeacher
};

typedef NS_ENUM(NSInteger, DQKMainViewCellSeparatorStyle) {
    DQKMainViewCellSeparatorStyleSingleLine,
    DQKMainViewCellSeparatorStyleNone
};

typedef NS_ENUM(NSInteger, DQKMainViewCellScoreStyle) {
    DQKMainViewCellScoreStyleMax ,
    DQKMainViewCellScoreStyleMin
};

@interface DQKMainViewCell : UIView


- (instancetype)initWithStyle:(DQKMainViewCellStyle) style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;
@property (strong, nonatomic) NSString *title;
@property (readonly, assign, nonatomic) DQKMainViewCellStyle style;
@property (assign, nonatomic) DQKMainViewCellSeparatorStyle separatorStyle;
@property (assign, nonatomic) NSInteger rowNumber;
@property (assign, nonatomic) NSInteger sectionNumber;
@property (assign, nonatomic) DQKMainViewCellScoreStyle scroreStyle;

@end
