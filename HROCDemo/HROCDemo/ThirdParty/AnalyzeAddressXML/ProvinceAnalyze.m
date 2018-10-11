//
//  ProvinceAnalyze.m
//  MoboApp
//
//  Created by mac on 12-12-25.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import "ProvinceAnalyze.h"

@implementation ProvinceAnalyze

- (void)startAnalyze
{
    fileName=@"Provinces.xml";
    [super startAnalyze];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"Province"])
    [shippingAddressArray addObject:attributeDict];
}
@end
