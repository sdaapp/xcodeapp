//
//  RunDetail.h
//  TableView
//
//  Created by James Miller on 30/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunDetail : NSObject {
@private
    NSString *type;
    NSDictionary *videoLinks;
    NSString *commentsLink;
}

@property (copy) NSString *type;
@property (copy) NSDictionary *videoLinks;
@property (copy) NSString *commentsLink;

- (id)initWithType:(NSString *)_type videoLinks:(NSDictionary *)vids andCommentsLink:(NSString *)comments;

@end
