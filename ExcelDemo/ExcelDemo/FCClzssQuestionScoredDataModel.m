//
//Created by ESJsonFormatForMac on 18/03/09.
//

#import "FCClzssQuestionScoredDataModel.h"
@implementation FCClzssQuestionScoredDataModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [FCClzssQuestionScoreModel class]};
}


@end

@implementation FCClzssQuestionScoreModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"studentList" : [FCStudentQuestionModel class]};
}


@end


@implementation FCStudentQuestionModel


@end


