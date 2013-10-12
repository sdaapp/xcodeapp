//
//  DetailViewController.h
//  TableView
//
//  Created by James Miller on 21/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@class SecondDetailViewController;

@interface DetailViewController : UIViewController {
    IBOutlet UITextView *body;
    IBOutlet UITableView *detailTable;
}
@property (strong, nonatomic) NSString *descriptionString;
@property (strong, nonatomic) NSString *FTPString;
@property (strong, nonatomic) NSArray *runDetails;

@property (strong, nonatomic) SecondDetailViewController *secondDetailController;

@end
