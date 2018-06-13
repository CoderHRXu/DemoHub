//
//  ViewController.m
//  ExcelDemo
//
//  Created by haoran on 2018/6/12.
//  Copyright © 2018年 haoran. All rights reserved.
//

#import "ViewController.h"

#import "DQKFreezeWindowView-JK/DQKFreezeWindowView.h"
#import "FCClzssQuestionScoredDataModel.h"


@interface ViewController ()<DQKFreezeWindowViewDataSource,DQKFreezeWindowViewDelegate>

//年级
@property (nonatomic, strong) NSMutableArray *questionsArray;
@property (nonatomic, strong) NSMutableArray *maxValueArray;
@property (nonatomic, strong) NSMutableArray *minValueArray;
/** 所有的学生信息(用于快速展示)  */
@property (nonatomic, strong) NSMutableArray *studentInfoArray;

@property (nonatomic, strong) DQKFreezeWindowView *freezeWindowView;
@end

@implementation ViewController

static NSString *questionCellID = @"questionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"开始加载");
    FCClzssQuestionScoredDataModel *dataModel = [FCClzssQuestionScoredDataModel fc_modelWithResponse:[self loadJson]];
    [self handleClzssQuestionScoredDataModel:dataModel isBigQuestion:NO];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSNumber *value = [NSNumber numberWithInt:UIDeviceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    [UIViewController attemptRotationToDeviceOrientation];
//    self.navigationController.navigationBarHidden = YES;
    [self configUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"加载完成"); // 创建 5秒

}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}


#pragma mark - data

- (NSDictionary *)loadJson{
    
    NSError*error;
    //获取文件路径
    NSString *filePath          =[[NSBundle mainBundle] pathForResource:@"1" ofType:@"json"];
    //根据文件路径读取数据
    NSData *jdata               = [[NSData alloc]initWithContentsOfFile:filePath];
    //格式化成json数据
    return [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
    
}

- (void)handleClzssQuestionScoredDataModel:(FCClzssQuestionScoredDataModel *)dataModel isBigQuestion:(BOOL)isBigQuestion{
    if (dataModel.isSuccess) {

        
        // 班级大题
        self.questionsArray                                 = [dataModel.data mutableCopy];
        
        
        self.maxValueArray                                  = [NSMutableArray array];
        self.minValueArray                                  = [NSMutableArray array];
        FCClzssQuestionScoreModel * questionScoreModel     = dataModel.data.firstObject;
        
        if (isBigQuestion) {
            
            self.studentInfoArray                          = [questionScoreModel.studentList mutableCopy];
            
            for (FCClzssQuestionScoreModel *questionScoreModel in dataModel.data) {
                
                NSMutableArray *arr                         = [NSMutableArray array];
                for (FCStudentQuestionModel *studentModel in questionScoreModel.studentList) {
                    
                    if (studentModel.attendStatus != 0  ){
                        [arr addObject:studentModel.questionScore];
                    }
                }
                NSString *maxValue                          = [NSString stringWithFormat:@"%@",[arr valueForKeyPath:@"@max.floatValue"]];
                NSString *minValue                          = [NSString stringWithFormat:@"%@",[arr valueForKeyPath:@"@min.floatValue"]];
                [self.maxValueArray addObject:maxValue];
                [self.minValueArray addObject:minValue];
            }
            
        }else{
            
            self.maxValueArray                              = [NSMutableArray array];
            self.minValueArray                              = [NSMutableArray array];
            self.studentInfoArray                           = [questionScoreModel.studentList mutableCopy];
            
            for (FCClzssQuestionScoreModel *questionScoreModel in dataModel.data) {
                
                NSMutableArray *arr                         = [NSMutableArray array];
                for (FCStudentQuestionModel *studentModel in questionScoreModel.studentList) {
                    
                    if (studentModel.attendStatus != 0  ){
                        [arr addObject:studentModel.questionScore];
                    }
                }
                NSString *maxValue                          = [NSString stringWithFormat:@"%@",[arr valueForKeyPath:@"@max.floatValue"]];
                NSString *minValue                          = [NSString stringWithFormat:@"%@",[arr valueForKeyPath:@"@min.floatValue"]];
                [self.maxValueArray addObject:maxValue];
                [self.minValueArray addObject:minValue];
            }
        }
        
        
    }else {
        
        [self.maxValueArray removeAllObjects];
        [self.minValueArray removeAllObjects];
        self.studentInfoArray                               = nil;
    }
    
}


#pragma mark - UI
- (void)configUI{
    
//    [self.freezeWindowView removeFromSuperview];
    CGRect frame = CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    self.freezeWindowView               = [[DQKFreezeWindowView alloc] initWithFrame:frame FreezePoint:CGPointMake(280, 40) cellViewSize:CGSizeMake(180, 44)];
    [self.view addSubview:self.freezeWindowView];
    self.freezeWindowView.dataSource    = self;
    self.freezeWindowView.delegate      = self;
    [self.freezeWindowView setSignViewWithContent:@"姓名" SecondContent:@"学号" DQKSignViewStyle:DQKSignViewStyleTwoSection];
    [self.freezeWindowView setSignViewBackgroundColor:[UIColor colorWithRed:243/ 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1]];
    
}


#pragma mark - DQKFreezeWindowViewDataSource,DQKFreezeWindowViewDelegate
- (DQKRowViewCell *)freezeWindowView:(DQKFreezeWindowView *)freezeWindowView cellAtRow:(NSInteger)row {
    
    static NSString *timeCell                       = @"timeCell";
    DQKRowViewCell *rowCell                         = [freezeWindowView dequeueReusableRowCellWithIdentifier:timeCell forRow:row];
    if (rowCell == nil) {
        rowCell                                     = [[DQKRowViewCell alloc] initWithStyle:DQKRowViewCellStyleJKTeacherTwoSection reuseIdentifier:timeCell];
        
    }
    if (row >= 0 && row < self.studentInfoArray.count) {
        FCStudentQuestionModel *student             = self.studentInfoArray[row];
        rowCell.title                               = student.studentName;
        rowCell.secondTitle                         = [NSString stringWithFormat:@"%@", student.studentNo];
    }
    
    rowCell.backgroundColor                         = [UIColor whiteColor];
    return rowCell;
}

- (DQKSectionViewCell *)freezeWindowView:(DQKFreezeWindowView *)freezeWindowView cellAtSection:(NSInteger)section {
    
    static NSString *dayCell = @"dayCell";
    DQKSectionViewCell *sectionCell = [freezeWindowView dequeueReusableSectionCellWithIdentifier:dayCell forSection:section];
    if (sectionCell == nil) {
        sectionCell.backgroundColor = [UIColor colorWithRed:243/ 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
        sectionCell = [[DQKSectionViewCell alloc] initWithStyle:DQKSectionViewCellStyleJKTeacher reuseIdentifier:dayCell];
    }
    if (section == 0) {
        sectionCell.title = @"成绩";
    } else if (section > 0 && section <= self.questionsArray.count + 1){
        
        FCClzssQuestionScoreModel *questionModel = self.questionsArray[section - 1];
        if (NO) {
            // TODO: 这里逻辑有待考证
            sectionCell.title               = questionModel.questionTitle ;
        }else{
            sectionCell.title               = [NSString stringWithFormat:@"%@(%@)",questionModel.questionTitle,questionModel.questionScore]; ;
        }
        
    }
    
    return sectionCell;
}

- (DQKMainViewCell *)freezeWindowView:(DQKFreezeWindowView *)freezeWindowView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    DQKMainViewCell *mainCell       = [freezeWindowView dequeueReusableMainCellWithIdentifier:questionCellID forIndexPath:indexPath];
    if (mainCell == nil) {
        
        mainCell                    = [[DQKMainViewCell alloc] initWithStyle:DQKMainViewCellStyleJKTeacher reuseIdentifier:questionCellID];
        mainCell.backgroundColor    = [UIColor whiteColor];
    }
    
    if (indexPath.section == 0 && indexPath.row < self.studentInfoArray.count) { // 成绩
        FCStudentQuestionModel *student                     = self.studentInfoArray[indexPath.row];
        
        if (NO) {
            
            float totalScore                                = student.totalScore.floatValue;
            float examScore                                 = student.examScore.floatValue;
            mainCell.title                                  = student.attendStatus == 0 ? @"--" : [NSString stringWithFormat :@"%.1f%%",totalScore/examScore *100.0];
        }else {
            if (student.attendStatus == 0) {
                mainCell.title                              = @"--";
            }else{
                mainCell.title                              = [NSString stringWithFormat:@"%.1f",student.totalScore.floatValue];
            }
            
        }
        
    }else if (indexPath.section > 0 && indexPath.section < self.questionsArray.count + 1 && indexPath.row < self.studentInfoArray.count) { // 小题
        
        FCClzssQuestionScoreModel *questionScoreModel       = self.questionsArray[indexPath.section - 1];
        FCStudentQuestionModel *student                     = questionScoreModel.studentList[indexPath.row];
        
     
        
        if (student.attendStatus == 0) {
            mainCell.title                                  = @"--";
        }else{
            mainCell.title                                  = [NSString stringWithFormat:@"%.1f",student.questionScore.floatValue];
        }

        NSNumber *sectionMaxValue                           = self.maxValueArray[indexPath.section - 1];
        NSNumber *sectionMinValue                           = self.minValueArray[indexPath.section - 1];
        
        if (![mainCell.title isEqualToString:@"--"] && student.questionScore.floatValue == sectionMaxValue.floatValue) {
            mainCell.scroreStyle = DQKMainViewCellScoreStyleMax;
        } else if (![mainCell.title isEqualToString:@"--"] && student.questionScore.floatValue == sectionMinValue.floatValue) {
            mainCell.scroreStyle = DQKMainViewCellScoreStyleMin;
        }
        
    }
    
    return mainCell;
}

- (NSInteger)numberOfRowsInFreezeWindowView:(DQKFreezeWindowView *)freezeWindowView {
    return self.studentInfoArray.count;
}

- (NSInteger)numberOfSectionsInFreezeWindowView:(DQKFreezeWindowView *)freezeWindowView {
    return self.questionsArray.count + 1;
}



@end
