//
//  BarChartViewController.m
//  ExcelDemo
//
//  Created by haoran on 2018/6/13.
//  Copyright © 2018年 haoran. All rights reserved.
//

#import "BarChartViewController.h"
#import <Charts/Charts-Swift.h>


@interface BarChartViewController ()<ChartViewDelegate>

@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"柱形图";
    [self stupBarChart];
}

- (void)stupBarChart{
    
    BarChartView *bar                           = [[BarChartView alloc] initWithFrame:CGRectMake(0, 64, 375, 400)];
    
    // UI
    bar.dragEnabled                             = YES; // 是否可拖动
    bar.doubleTapToZoomEnabled                  = NO;  // 双击放大
    
    bar.chartDescription.text                   = @"这是柱状图名称";
    bar.chartDescription.font                   = [UIFont systemFontOfSize:10];
    bar.chartDescription.yOffset                = -40;
 
    bar.highlightPerTapEnabled                  = NO;  // 控制柱会否可点击触发高亮，设置NO，代理方法不会触发
    bar.highlightFullBarEnabled                 = NO;
    bar.highlightPerDragEnabled                 = NO;  // 控制柱拖动缩放的时候点击高亮

    bar.drawGridBackgroundEnabled               = NO;
    
    // 数据
    ChartXAxis *xAxis                           = bar.xAxis;
    xAxis.labelPosition                         = XAxisLabelPositionBottom;  // 每个柱图下面label的位置
    xAxis.labelFont                             = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled                  = NO; // 每个柱中间的竖线
    xAxis.granularity                           = 1.0; // only intervals of 1 day  柱之间的最小间距
    xAxis.labelCount                            = 7;
    
    NSNumberFormatter *leftAxisFormatter        = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.minimumFractionDigits     = 0;
    leftAxisFormatter.maximumFractionDigits     = 1;
    leftAxisFormatter.negativeSuffix            = @"";
    leftAxisFormatter.positiveSuffix            = @"%";
    
    ChartYAxis *leftAxis                        = bar.leftAxis;
    leftAxis.labelFont                          = [UIFont systemFontOfSize:10];
    leftAxis.labelCount                         = 5;
    leftAxis.valueFormatter                     = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition                      = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop                           = 0.15;
    leftAxis.axisMinimum                        = 0; // 坐标最小值
    leftAxis.drawAxisLineEnabled                = YES; // y轴是否绘制
    leftAxis.drawLabelsEnabled                  = YES; // y轴上的label是否显示
    
    ChartYAxis *rightAxis                       = bar.rightAxis;
    rightAxis.enabled                           = NO; // 柱状图右侧Y轴是否可以显示
    rightAxis.drawGridLinesEnabled              = NO;
    rightAxis.labelFont                         = [UIFont systemFontOfSize:10];
    rightAxis.labelCount                        = 0;
    rightAxis.valueFormatter                    = leftAxis.valueFormatter;
    rightAxis.spaceTop                          = 0.15;
    rightAxis.axisMinimum                       = 0.0;
    
    ChartLegend *legend                         = bar.legend;
    legend.horizontalAlignment                  = ChartLegendHorizontalAlignmentLeft;
    legend.verticalAlignment                    = ChartLegendVerticalAlignmentBottom;
    legend.orientation                          = ChartLegendOrientationHorizontal;
    legend.drawInside                           = NO;
    legend.form                                 = ChartLegendFormSquare;
    legend.formSize                             = 9.0;
    legend.xEntrySpace                          = 4.0;
    
    NSMutableArray *yValues                     = [NSMutableArray array];
    NSArray *numArray                           = @[@10, @60, @30, @40, @33];
    for (NSNumber *num in numArray) {
        NSInteger index = [numArray indexOfObject:num];
        BarChartDataEntry *dataEntry = [[BarChartDataEntry alloc] initWithX:index y:num.integerValue];
        [yValues addObject:dataEntry];
    }
    
    BarChartDataSet *set                        = [[BarChartDataSet alloc] initWithValues:yValues label:@"颜色"];
    set.colors                                  = @[UIColor.redColor, UIColor.purpleColor, UIColor.greenColor, UIColor.blueColor];
    set.valueTextColor                          = UIColor.blackColor; // 柱上的值文字颜色
    set.valueFont                               = [UIFont systemFontOfSize:12]; // 柱上的值文字字体
//    set
    NSMutableArray *dataSets                    = [NSMutableArray array];
    [dataSets addObject:set];
    
    BarChartData *data                          = [[BarChartData alloc] initWithDataSets:dataSets];
    data.barWidth                               = 0.6; // 0~1的比例宽度

    
    
    bar.data                                    = data;
    bar.delegate                                = self;
    
    [self.view addSubview:bar];
    
    [bar animateWithYAxisDuration:1.5];
}


#pragma mark - ChartViewDelegate
- (void)chartTranslated:(ChartViewBase *)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
    NSLog(@"chartTranslated dx:%f dy:%f",dX,dY);
}

- (void)chartScaled:(ChartViewBase *)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    NSLog(@"chartScaled scaleX:%f scaleY:%f", scaleX, scaleY);
}


- (void)chartValueNothingSelected:(ChartViewBase *)chartView{
    NSLog(@"chartValueNothingSelected");
}

- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    
    NSLog(@"chartValueSelected entry:%@ highlight:%@", entry, highlight);
}


@end
