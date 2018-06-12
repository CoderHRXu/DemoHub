//
//  DQKFreezeView.h
//  DQKFreezeWindowView
//
//  Created by 宋宋 on 15/7/15.
//  Copyright © 2015年 dianqk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DQKSignViewStyle) {
    DQKSignViewStyleDefault,
    DQKSignViewStyleTwoSection
};

@interface DQKSignView : UIView

- (void)setContent:(NSString *)content SecondContent:(NSString *)seContent DQKSignViewStyle:(DQKSignViewStyle)style;
@end
