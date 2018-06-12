//
//  DQKRowViewCell.h
//  DQKFreezeWindowView
//
//  Created by 宋宋 on 15/7/15.
//  Copyright © 2015年 dianqk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DQKRowViewCellStyle) {
    DQKRowViewCellStyleDefault,
    DQKRowViewCellStyleCustom,
    DQKRowViewCellStyleJKTeacher,
    DQKRowViewCellStyleJKTeacherTwoSection
};

typedef NS_ENUM(NSInteger, DQKRowViewCellSeparatorStyle) {
    DQKRowViewCellSeparatorStyleSingleLine,
    DQKRowViewCellSeparatorStyleNone
};


@interface DQKRowViewCell : UIView

- (instancetype)initWithStyle:(DQKRowViewCellStyle) style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *secondTitle;
@property (readonly, assign, nonatomic) DQKRowViewCellStyle style;
@property (assign, nonatomic) DQKRowViewCellSeparatorStyle separatorStyle;

@end
