//
//  XFAlertView.h
//  Dingdong
//
//  Created by Jeremy on 2016/11/22.
//  Copyright © 2016年 RJS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CompleteBlock) (NSInteger buttonIndex);
@interface XFAlertView : UIAlertView

/** 持续存在点击不消失，默认点击消失 */
@property (nonatomic, assign) BOOL continueLiving;

- (void)showAlertViewWithCompleteBlock:(CompleteBlock)block;
@end
