//
//  XFLabel.h
//  Dingdong
//
//  Created by Jeremy on 2017/1/5.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
}VerticalAlignment;

@interface XFLabel : UILabel
@property (nonatomic)VerticalAlignment verticalAlignment;
@end
