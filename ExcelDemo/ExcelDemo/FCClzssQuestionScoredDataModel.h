//
//  FCClzssQuestionScoredDataModel.h
//  Teacher
//
//  Created by haoran on 2018/03/09.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

#import "FCBaseDataModel.h"

/**********  报表 用于班级大小题新接口  ********/

@class FCClzssQuestionScoreModel,FCStudentQuestionModel;
@interface FCClzssQuestionScoredDataModel : FCBaseDataModel

@property (nonatomic, strong) NSArray<FCClzssQuestionScoreModel *> *data;

@end

@interface FCClzssQuestionScoreModel : NSObject

@property (nonatomic, strong) NSString *questionTitle;

@property (nonatomic, assign) NSInteger sequence;

@property (nonatomic, strong) NSString *questionScore;

@property (nonatomic, strong) NSString *clzssAvgScore;

@property (nonatomic, strong) NSArray<FCStudentQuestionModel *> *studentList;

@property (nonatomic, strong) NSString *gradeRate;

@property (nonatomic, strong) NSString *clzssRate;

@property (nonatomic, assign) NSInteger questionId;

@property (nonatomic, strong) NSString *gradeAvgScore;

@end

@interface FCStudentQuestionModel : NSObject

@property (nonatomic, strong) NSString *questionScore;

@property (nonatomic, assign) NSInteger studentId;

@property (nonatomic, strong) NSString *examScore;

@property (nonatomic, strong) NSString *studentNo;

@property (nonatomic, assign) NSInteger interimStatus;

@property (nonatomic, copy) NSString *studentName;

@property (nonatomic, strong) NSString * totalScore;

@property (nonatomic, assign) NSInteger passStatus;

@property (nonatomic, assign) NSInteger attendStatus;

@property (nonatomic, assign) NSInteger clzssRank;

@property (nonatomic, strong) NSString *scoreRate;
@end

