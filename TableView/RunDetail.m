//
//  RunDetail.m
//  TableView
//
//  Created by James Miller on 30/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import "RunDetail.h"

@implementation RunDetail

@synthesize type, videoLinks, commentsLink;

- (id)initWithType:(NSString *)_type videoLinks:(NSDictionary *)vids andCommentsLink:(NSString *)comments
{
    self = [super init];
    if (self) {
        type = _type;
        videoLinks = vids;
        commentsLink = comments;
    }
    
    return self;
}

- (NSString *)description
{
    return self.type;
}

@end
