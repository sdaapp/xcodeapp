//
//  MasterViewController.h
//  TableView
//
//  Created by James Miller on 21/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>


@class DetailViewController;
@class Reachability;

@interface MasterViewController : UITableViewController <UISearchBarDelegate> {
@private
    IBOutlet UISearchBar *aSearchBar;
    NSMutableArray *searchArray;
    BOOL isFiltered;
   IBOutlet UIActivityIndicatorView *activity;
    UIView *subview;

 
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
    
    
}
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, retain) UIView *subView;
@property (nonatomic, strong) NSMutableArray *objects;
@property (strong, nonatomic) DetailViewController *detailViewController;



@end
