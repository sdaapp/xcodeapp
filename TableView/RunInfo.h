//
//  RunInfo.h
//  TableView
//
//  Created by James Miller on 30/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunInfo : NSObject {
@private
    NSString *title;
    NSString *subtitle;
    NSString *FTPLink;
    NSArray *runs;
}

@property (copy) NSString *title;
@property (copy) NSString *subtitle;
@property (copy) NSString *FTPLink;
@property (copy) NSArray *runs;

- (id)initWithTitle:(NSString *)_title subtitle:(NSString *)_subtitle link:(NSString *)link andRuns:(NSArray *)array;

@end
