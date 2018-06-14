//
//  BarChartViewController.m
//  ExcelDemo
//
//  Created by haoran on 2018/6/13.
//  Copyright © 2018年 haoran. All rights reserved.
//

#import "BarChartViewController.h"
#import <Charts/Charts-Swift.h>


@interface BarChartViewController ()

@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"柱形图";
    [self stupBarChart];
}

- (void)stupBarChart{
    
    BarChartView *bar                           = [[BarChartView alloc] initWithFrame:CGRectMake(0, 64, 375, 400)];
    ChartXAxis *xAxis                           = bar.xAxis;
    xAxis.labelPosition                         = XAxisLabelPositionBottom;
    xAxis.labelFont                             = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled                  = NO;
    xAxis.granularity                           = 1.0; // only intervals of 1 day
    xAxis.labelCount                            = 7;
    
    [self.view addSubview:bar];
}


@end
