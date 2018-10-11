//
//  SuperAnalyzeShippingAddress.m
//  MoboApp
//
//  Created by mac on 12-12-25.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import "SuperAnalyzeShippingAddress.h"

@implementation SuperAnalyzeShippingAddress
@synthesize shippingAddressArray;
@synthesize isAnalyzed;

- (id)init
{
    if(self=[super init])
    {
        shippingAddressArray=[[NSMutableArray alloc] initWithCapacity:42];
        [self startAnalyze];
    }
    return self;
}

- (void)startAnalyze
{
    isAnalyzed=NO;
    NSString *resourcePath=[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],fileName];
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:resourcePath]];
    parser.delegate=self;
    [parser parse];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    isAnalyzed=YES;
}
@end
