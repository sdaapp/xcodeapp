//
//  RunInfo.m
//  TableView
//
//  Created by James Miller on 30/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import "RunInfo.h"

@implementation RunInfo

@synthesize title, subtitle, FTPLink, runs;

- (id)initWithTitle:(NSString *)_title subtitle:(NSString *)_subtitle link:(NSString *)link andRuns:(NSArray *)array
{
    self = [super init];
    if (self) {
        title = _title;
        subtitle = _subtitle;
        FTPLink = link;
        runs = array;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@) with runs: %@",self.title,self.subtitle,self.runs];
}

@end