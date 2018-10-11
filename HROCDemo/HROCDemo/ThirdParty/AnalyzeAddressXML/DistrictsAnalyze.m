//
//  DistrictsAnalyze.m
//  MoboApp
//
//  Created by mac on 12-12-25.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import "DistrictsAnalyze.h"

@implementation DistrictsAnalyze
- (id)init
{
    cId=@"1";
    if(self=[super init])
    {
    
    }
    return self;
}
- (void)startAnalyze
{
    fileName=@"Districts.xml";
    [super startAnalyze];
}
- (void)startAnalyze:(NSString*)_cId
{
    [shippingAddressArray removeAllObjects];
    cId=_cId;
    [self startAnalyze];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    static int a=0;
    if([[attributeDict valueForKey:@"CID"] isEqualToString:cId])
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
