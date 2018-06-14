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
    
    PieChartView *pieView                   = [[PieChartView alloc] initWithFrame:CGRectMake(0, 100, 375, 300)];
    [self.view addSubview:pieView];
    pieView.delegate                        = self;
    ChartLegend *legend                     = pieView.legend;
    legend.horizontalAlignment              = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment                = ChartLegendVerticalAlignmentTop;
    legend.orientation                      = ChartLegendOrientationVertical;
    legend.drawInside                       = NO;
    legend.xEntrySpace                      = 7.0;
    legend.yEntrySpace                      = 0;
    legend.yOffset                          = 0;
    
    // 设置样式
    

    pieView.entryLabelColor                 = UIColor.whiteColor;
    
//    pieView.usePercentValuesEnabled = YES;
    pieView.centerText                      = @"中间文字";
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode            = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment                = NSTextAlignmentCenter;
    
    NSMutableAttributedString *centerText   = [[NSMutableAttributedString alloc] initWithString:@"Charts\nby Daniel Cohen Gindi"];
    [centerText setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, centerText.length)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f],
                                NSForegroundColorAttributeName: UIColor.grayColor
                                } range:NSMakeRange(10, centerText.length - 10)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:11.f],
                                NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
                                } range:NSMakeRange(centerText.length - 19, 19)];
    
    pieView.centerAttributedText            = centerText;// 中间富文本
    pieView.drawHoleEnabled                 = YES; //饼状图是否是空心
    pieView.transparentCircleRadiusPercent  = 0.4; //半透明空心半径占比
    pieView.transparentCircleColor          = UIColor.redColor; //半透明空心的颜色
    
    ChartDescription *description           = [[ChartDescription alloc] init];
    description.text                        = @"成绩分段饼图";
    description.font                        = [UIFont systemFontOfSize:16];
    description.textColor                   = UIColor.redColor;
    pieView.chartDescription                = description;
    
    
    // 设置数据
    pieView.data                            = [self pieChartData];
    
    
    
//    [pieView animateWithXAxisDuration:1.5 easingOption:ChartEasingOptionEaseOutBack];
    [pieView animateWithXAxisDuration:1.5 yAxisDuration:1.5 easingOption:ChartEasingOptionEaseOutBack];
}

- (PieChartData *)pieChartData{
    
    // 每个区块的名称数据
    NSMutableArray *values          = [NSMutableArray array];
    NSArray *numArray               = @[@0.1, @0.2, @0.3, @0.4];
    NSArray *areaNameArray          = @[@"优秀", @"良好", @"及格", @"不及格"];
    
    for (int i = 0; i < 4; i++) {
//        NSString *titleString = [NSString stringWithFormat:@"第%d区域",i];
        
//        PieChartDataEntry *dataEntry = [[PieChartDataEntry alloc] initWithValue:[numArray[i] integerValue]  label:areaNameArray[i]];
        PieChartDataEntry *dataEntry = [[PieChartDataEntry alloc] initWithValue:[numArray[i] doubleValue] label:areaNameArray[i] icon:[UIImage imageNamed:@"icon"] data:nil];
        
        [values addObject:dataEntry];
    }
    
    PieChartDataSet *dataSet        = [[PieChartDataSet alloc] initWithValues:values label:@"自定义设置" ];
    dataSet.drawIconsEnabled        = NO;
    dataSet.colors                  = @[UIColor.redColor, UIColor.blueColor, UIColor.purpleColor, UIColor.greenColor];
    
    PieChartData *data              = [[PieChartData alloc] initWithDataSet:dataSet];
    NSNumberFormatter *formatter    = [[NSNumberFormatter alloc] init];
    formatter.numberStyle           = NSNumberFormatterNoStyle;
    formatter.maximumFractionDigits = 2;//小数位数
    formatter.multiplier            = @1.f;
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    [data setValueTextColor:[UIColor whiteColor]];
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
