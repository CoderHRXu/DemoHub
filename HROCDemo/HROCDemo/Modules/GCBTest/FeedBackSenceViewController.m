//
//  FeedBackSenceViewController.m
//  HROCDemo
//
//  Created by haoran on 2019/8/4.
//  Copyright © 2019 Sunfit. All rights reserved.
//

#import "FeedBackSenceViewController.h"
#import <Masonry/Masonry.h>
#import "UICollectionViewLeftAlignedLayout.h"
#import "FeedBackSenceCell.h"
#import "FeedBackSenceSectionHeader.h"


@interface FeedBackSenceViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>


/** collectionview  */
@property (nonatomic, strong) UICollectionView *collectionView;

/** 数据  */
@property (nonatomic, strong) NSArray *dataDict;

/** 数据源  */
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation FeedBackSenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.title = @"问题场景";
    // 从接口拉的数据
    self.dataDict = @[
                      [@{
                          @"groupName": @"考勤",
                          @"list" : @[@"班次设置", @"班次设置", @"班次设置", @"班次设置"],
                          @"show" : @(YES)
                          } mutableCopy],
                      
                      [@{
                          @"groupName": @"审批",
                          @"list" : @[@"班次设置", @"班次设置", @"班次设置", @"班次设置", @"班次设置阿里", @"班次设是是是置"],
                           @"show" : @(YES)
                          } mutableCopy],

                      [@{
                          @"groupName": @"审批",
                          @"list" : @[@"打哈钉钉", @"班次设置", @"班次设置", @"班次设置阿里", @"都还好都还好"],
                          @"show" : @(YES)
                          } mutableCopy],

                      
                      ];
    
    self.dataArray = [self.dataDict mutableCopy];
    [self setupCollectionView];
}

#pragma mark - UI
- (void)setupCollectionView {
    
    //创建参数布局
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    layout.minimumLineSpacing           = 15;
    layout.minimumInteritemSpacing      = 15;
    
    UICollectionView *collectionView    = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor      = [UIColor whiteColor];
    collectionView.dataSource           = self;
    collectionView.delegate             = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.scrollEnabled        = YES;
    collectionView.bounces              = YES;
    collectionView.contentInset         = UIEdgeInsetsMake(0 , 20, 0, 20);

    self.collectionView                 = collectionView;
    
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [collectionView registerClass:FeedBackSenceCell.class forCellWithReuseIdentifier:NSStringFromClass(FeedBackSenceCell.class)];
    [collectionView registerClass:FeedBackSenceSectionHeader.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(FeedBackSenceSectionHeader.class)];
    
}

#pragma mark - Action
- (void)sectionHeaderTap:(UITapGestureRecognizer *)tap {
    
    FeedBackSenceSectionHeader *header  = (FeedBackSenceSectionHeader *)tap.view;
    NSInteger section                   = header.tag;
    NSMutableDictionary *dict           = self.dataArray[section];
    dict[@"show"]                       = @(![dict[@"show"] boolValue]);
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.dataArray.count) {
        NSDictionary *dict              = [self.dataArray objectAtIndex:section];
        if ([dict[@"show"] boolValue]) {
            NSArray *array              = [dict objectForKey:@"list"];
            return array.count;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedBackSenceCell *cell             = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(FeedBackSenceCell.class) forIndexPath:indexPath];
    if (self.dataArray.count) {
        NSDictionary *dict              = [self.dataArray objectAtIndex:indexPath.section];
        if ([dict[@"show"] boolValue]) {
            NSArray *array              = [dict objectForKey:@"list"];
            NSString *name              = [array objectAtIndex:indexPath.row];
            cell.label.text             = name;
        }
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView *supplementaryView;

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        FeedBackSenceSectionHeader *sectionHeader   = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(FeedBackSenceSectionHeader.class) forIndexPath:indexPath];
        
        NSDictionary *dict                          = [self.dataArray objectAtIndex:indexPath.section];
        sectionHeader.groupName                     = dict[@"groupName"];
        supplementaryView                           = sectionHeader;
        sectionHeader.backgroundColor               = [UIColor yellowColor];
        sectionHeader.tag                           = indexPath.section;
        [sectionHeader addTarget:self action:@selector(sectionHeaderTap:)];
    }

    return supplementaryView;


}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat btnW        = 0;
    NSDictionary *dict  = [self.dataArray objectAtIndex:indexPath.section];
    if ([dict[@"show"] boolValue]) {
        NSArray *array  = [dict objectForKey:@"list"];
        NSString *name  = [array objectAtIndex:indexPath.row];
        btnW            = name.length * 14 + 16;
    }
    
  
   
    return CGSizeMake(btnW, 30);
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(KScreenW, 45);

}


@end
