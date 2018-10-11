//
//  WelcomeViewController.m
//  HROCDemo
//
//  Created by Jeremy Pan on 16/7/18.
//  Copyright © 2016年 RJS. All rights reserved.
//

#import "WelcomeViewController.h"

#import "ImageViewController.h"
#import "IdentityTypeViewController.h"



@interface WelcomeViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, IdentityTypeDelegate>
@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) UIViewController *pengdingViewController;

@property (nonatomic, strong) NSArray<UIViewController *> *pageArray;
/** Index切换记录  */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *indexRecordArray;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPageData];
    [self layoutView];
}

- (void)initPageData {
        
    ImageViewController *vc1 = [[ImageViewController alloc] init];
    vc1.imageNameString = @"welcome_1";
    
    ImageViewController *vc2 = [[ImageViewController alloc] init];
    vc2.imageNameString = @"welcome_2";

    IdentityTypeViewController *vc3 = [[IdentityTypeViewController alloc] init];
    vc3.delegate = self;
    
    self.pageArray = @[vc1, vc2, vc3];
}

- (void)layoutView {
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal
                                                                            options: @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)}];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController setViewControllers:@[self.pageArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma mark - UIPageViewControllerDataSource & UIPageViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger beforeIndex = self.indexRecordArray.lastObject.integerValue - 1;
    if (beforeIndex < 0) {
        return nil;
    }
    return [self.pageArray objectAtIndex:beforeIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger afterIndex = self.indexRecordArray.lastObject.integerValue + 1;
    if (afterIndex > self.pageArray.count - 1) {
        return nil;
    }
    return [self.pageArray objectAtIndex:afterIndex];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    self.pengdingViewController = pendingViewControllers.firstObject;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {
        
        [self.pageArray enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (self.pengdingViewController == obj) {
                
                [self.indexRecordArray addObject:@(idx)];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - IdentityTypeDelegate
- (void)loadPageWithAppType:(NSInteger)appType {
    


    if (self.block) {
        self.block();
    }
}

#pragma mark - 
- (NSMutableArray<NSNumber *> *)indexRecordArray {
    
    if (!_indexRecordArray) {
        
        _indexRecordArray = [NSMutableArray arrayWithObject:@(0)];
    }
    return _indexRecordArray;
}

@end
