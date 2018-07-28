//
//  ViewController.m
//  PullDownMenu
//
//  Created by apple on 2018/7/28.
//  Copyright © 2018年 haoran. All rights reserved.
//

#import "ViewController.h"

#import "Masonry.h"
//#import "UIColor+YYAdd.h"

@interface ViewController ()

/** 顶部view  */
@property (nonatomic, strong) UIView *topView;
/** 提示view  */
@property (nonatomic, strong) UIView *tipView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layout];

}


- (void)layout{
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}

- (UIView *)topView{
    if (!_topView) {
        _topView                    = [[UIView alloc] init];
        _topView.backgroundColor    = [UIColor grayColor];
        UILabel *label              = [[UILabel alloc] init];
        label.text                  = @"按";
        label.font                  = [UIFont fontWithName:@"PingHei-Text" size:14];
//        label.textColor             = [UIColor colorWithHexString:@"333333"];
        [_topView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_topView).offset(20);
            make.centerY.equalTo(self->_topView);
        }];
        UIButton *btn               = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"得分率" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font         = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius      = 2;
        btn.layer.masksToBounds     = YES;
//        btn.layer.borderColor       = [UIColor colorWithHexString:@"#D3DCE6"].CGColor;
        btn.layer.borderWidth       = 2;
        [_topView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).offset(5);
            make.centerY.equalTo(label.mas_centerY);
            make.height.mas_equalTo(26);
            make.width.mas_equalTo(90);
        }];
        UILabel *rightLabel         = [[UILabel alloc] init];
        rightLabel.text             = @"排列";
//        rightLabel.textColor        = [UIColor colorWithHexString:@"333333"];
        rightLabel.font             = [UIFont systemFontOfSize:14];
        [_topView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(btn.mas_right).offset(5);
            make.centerY.equalTo(btn);
        }];
    }
    return _topView;
}
@end
