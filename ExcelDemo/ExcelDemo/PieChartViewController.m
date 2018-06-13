//
//  PieChartViewController.m
//  ExcelDemo
//
//  Created by haoran on 2018/6/12.
//  Copyright © 2018年 haoran. All rights reserved.
//

#import "PieChartViewController.h"
#import <Charts/Charts-Swift.h>

@interface PieChartViewController ()<ChartViewDelegate>

@end

@implementation PieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCharts];
}

- (void)addCharts{
    
    PieChartView *pie1          = [[PieChartView alloc] initWithFrame:CGRectMake(0, 100, 375, 300)];
    [self.view addSubview:pie1];
    pie1.delegate               = self;
    ChartLegend *legend         = pie1.legend;
    legend.horizontalAlignment  = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment    = ChartLegendVerticalAlignmentTop;
    legend.orientation          = ChartLegendOrientationVertical;
    legend.drawInside           = NO;
    legend.xEntrySpace          = 7.0;
    legend.yEntrySpace          = 0;
    legend.yOffset              = 0;
    
    // 样式
    
    //半透明空心半径占比
    pie1.transparentCircleRadiusPercent = 1.0;
    pie1.entryLabelColor        = UIColor.whiteColor;
    [pie1 animateWithXAxisDuration:1.5 easingOption:ChartEasingOptionEaseOutBack];
    
    // data
    pie1.data                   = [self pieChartData];
}

- (PieChartData *)pieChartData{
    
    // 每个区块的名称数据
    NSMutableArray *values = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        NSString *titleString = [NSString stringWithFormat:@"第%d个区域",i];
        PieChartDataEntry *dataEntry = [[PieChartDataEntry alloc] initWithValue:25 label:titleString];
        [values addObject:dataEntry];
    }
    
    PieChartDataSet *dataSet        = [[PieChartDataSet alloc] initWithValues:values label:@"xxxx"];
    dataSet.drawIconsEnabled        = NO;
    dataSet.colors                  = @[UIColor.redColor, UIColor.blueColor, UIColor.purpleColor, UIColor.greenColor];
    
    PieChartData *data              = [[PieChartData alloc] initWithDataSet:dataSet];
    NSNumberFormatter *formatter    = [[NSNumberFormatter alloc] init];
    formatter.numberStyle           = NSNumberFormatterNoStyle;
    formatter.maximumFractionDigits = 2;//小数位数
    formatter.multiplier            = @1.f;
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    [data setValueTextColor:[UIColor blackColor]];
    [data setValueFont:[UIFont systemFontOfSize:15]];
    
    return data;
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight{
    
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView{
    
    NSLog(@"chartValueNothingSelected");
}


@end
