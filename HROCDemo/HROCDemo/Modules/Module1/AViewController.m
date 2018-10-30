//
//  AViewController.m
//  HROCDemo
//
//  Created by haoran on 2018/10/11.
//  Copyright © 2018年 Sunfit. All rights reserved.
//

#import "AViewController.h"

#import "Person.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];

    
    NSMutableSet *mutSet = [NSMutableSet set];
    Person *person1 = [[Person alloc] initWithID:1 name:@"nihao"];
    Person *person2 = [[Person alloc] initWithID:2 name:@"nihao2"];
    NSLog(@"begin add %@",person1);
    [mutSet addObject:person1];
    NSLog(@"after add %@",person1);
    
    NSLog(@"begin add %@",person2);
    [mutSet addObject:person2];
    NSLog(@"after add %@",person2);
    
    NSLog(@"count = %d",mutSet.count);
    
    Person *person3 = [[Person alloc] initWithID:1 name:@"nihao"];
    NSLog(@"begin add %@",person3);
    [mutSet addObject:person3];
    NSLog(@"after add %@",person3);
    
    NSLog(@"count = %d",mutSet.count);
    
  
    
}

- (void)test{
    
    Person *p1 = [[Person alloc] init];
    Person *p2 = p1;
    NSMutableSet *set = [NSMutableSet set];
    [set addObject:p1];
    NSLog(@"p1 == p2 %d", (p1 == p2));
    NSLog(@"p1 isEqual p2 %d", [p1 isEqual:p2]);
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
//    NSLog(@"3");
    
    [self test];
    
//    NSArray *placeholder = [NSArray alloc];
//    NSArray *arr1 = [[NSArray alloc] init];
//    NSArray *arr2 = [[NSArray alloc] initWithObjects:@0, nil];
//    NSArray *arr3 = [[NSArray alloc] initWithObjects:@0, @1, nil];
//    NSArray *arr4 = [[NSArray alloc] initWithObjects:@0, @1, @2, nil];
//
//    NSLog(@"placeholder: %s", object_getClassName(placeholder));
//    NSLog(@"arr1: %s", object_getClassName(arr1));
//    NSLog(@"arr2: %s", object_getClassName(arr2));
//    NSLog(@"arr3: %s", object_getClassName(arr3));
//    NSLog(@"arr4: %s", object_getClassName(arr4));
//
//    NSMutableArray *mPlaceholder = [NSMutableArray alloc];
//    NSMutableArray *mArr1 = [[NSMutableArray alloc] init];
//    NSMutableArray *mArr2 = [[NSMutableArray alloc] initWithObjects:@0, nil];
//    NSMutableArray *mArr3 = [[NSMutableArray alloc] initWithObjects:@0, @1, nil];
//
//    NSLog(@"mPlaceholder: %s", object_getClassName(mPlaceholder));
//    NSLog(@"mArr1: %s", object_getClassName(mArr1));
//    NSLog(@"mArr2: %s", object_getClassName(mArr2));
//    NSLog(@"mArr3: %s", object_getClassName(mArr3));
}


@end
