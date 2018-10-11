//
//  CityAnalyze.m
//  MoboApp
//
//  Created by mac on 12-12-25.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import "CityAnalyze.h"

@implementation CityAnalyze
- (id)init
{
    pId=@"1";
    if(self=[super init])
    {
        
    }
    return self;
}
- (void)startAnalyze
{
    fileName=@"Cities.xml";
    [super startAnalyze];
}
- (void)startAnalyze:(NSString*)_pId
{
    [shippingAddressArray removeAllObjects];
    pId=_pId;
    [self startAnalyze];
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    static int a=0;
    if([[attributeDict valueForKey:@"PID"] isEqualToString:pId])
    {
        a=1;
        [shippingAddressArray addObject:attributeDict];
    }
    else
    {
        if(a==1)
        {
            isAnalyzed=YES;
            a=0;
        }
    }
}
@end
