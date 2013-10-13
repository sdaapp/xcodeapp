//
//  MasterViewController.m
//  TableView
//
//  Created by James Miller on 21/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import "MasterViewController.h"
#import "RunInfo.h"
#import "RunDetail.h"
#import "DetailViewController.h"
#import "Reachability.h"

@implementation MasterViewController

@synthesize objects = _objects;
@synthesize subView;
@synthesize activity;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Games", @"Master");
        isFiltered = FALSE;
        [[UINavigationBar appearance] setTintColor:[UIColor lightGrayColor]];
    }
    return self;
}

-(void)checkReachability
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if(internetStatus == NotReachable) {
        UIAlertView *errorView;
        
        errorView = [[UIAlertView alloc]
                     initWithTitle: NSLocalizedString(@"Network error", @"Network error")
                     message: NSLocalizedString(@"Internet connection not found. You need it to load this data", @"Network error")
                     delegate: self
                     cancelButtonTitle: NSLocalizedString(@"OK", @"Network error") otherButtonTitles: nil];
        
        [errorView show];
    }
}



- (void)viewDidLoad
{
    [self checkReachability];
    
    [super viewDidLoad];
    
    [self.tableView setContentOffset:CGPointMake(0,44) animated:NO];

    
  
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    //refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull to Refresh"];

    
    [refreshControl addTarget:self action:@selector(beginRefreshing)forControlEvents:UIControlEventValueChanged];
   
    self.refreshControl = refreshControl;
    
    
    
   refreshControl.tintColor = [UIColor whiteColor];
    
    activity.center=self.view.center;
    [self.view addSubview:activity];
    [activity startAnimating];
    [self loadList];
  
    
}

-(void)beginRefreshing{
   
    
    
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
    
    [formattedDate setDateFormat:@"MMM d, h:mm a"];
    
    NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:lastupdated];
    

    [self loadList];
    
}





- (void)loadList
{
    if (self.refreshControl) {
        
        //Here we start the background loading
        
        dispatch_async(dispatch_queue_create("LoadTxt", NULL), ^{
            
            NSError *error;
            
            //Here we load the text
            
            NSURL *gamesFile = [NSURL URLWithString:@"http://www.sdaapp.net/Games.plist"];
            NSArray *root = [[NSArray alloc] initWithContentsOfURL:gamesFile];
            
            
            self.objects = [[NSMutableArray alloc] init];
            for (NSMutableDictionary *cellInfo in root) {
                RunInfo *run = [[RunInfo alloc] initWithTitle:[cellInfo objectForKey:@"Title"]
                                                     subtitle:[cellInfo objectForKey:@"Subtitle"]
                                                         link:[cellInfo objectForKey:@"FTPLink"]
                                                      andRuns:[cellInfo objectForKey:@"SecondTable"]];
                
                [self.objects addObject:run];
                
            }
            
            //We've got the text now, got back to foreground
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (error) NSLog(@"Something went wrong: %@",error);
                else {
                    
                    
                    [self.tableView reloadData];
                    [activity stopAnimating];
                    [self.activity removeFromSuperview];
                    [self.refreshControl endRefreshing];
                    
                }
                //We've now successfully set the text
                
            });
        });
    }
}







- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect rect = aSearchBar.frame;
    rect.origin.y = MIN(0, scrollView.contentOffset.y);
    aSearchBar.frame = rect;
}



#pragma mark - SearchBar Delegate



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText == nil || searchText.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = TRUE;
        searchArray = [[NSMutableArray alloc] init];
        for (RunInfo *item in self.objects) {
            NSRange titleRange = [item.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange subtitleRange = [item.subtitle rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleRange.location != NSNotFound || subtitleRange.location != NSNotFound)
            {
                [searchArray addObject:item];
            }
        }
    }
    
    [self.tableView reloadData];

}


-( void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [aSearchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    aSearchBar.text = @"";
    [aSearchBar resignFirstResponder];
    isFiltered = NO;
    aSearchBar.backgroundColor = [UIColor lightGrayColor];
    if (floor(NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1)) {
        [self.tableView setContentOffset:CGPointMake(0, 44) animated:YES];
    } else {
        [self.tableView setContentOffset:CGPointMake(0,-20) animated:YES];
    }
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (isFiltered) ? [searchArray count] : [self.objects count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize: 15];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor blackColor];
        
    
        
    }
    
    RunInfo *info = (isFiltered) ? [searchArray objectAtIndex:indexPath.row] : [self.objects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = info.title;
    cell.detailTextLabel.text = info.subtitle;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    
    RunInfo *info = (isFiltered) ? [searchArray objectAtIndex:indexPath.row] : [self.objects objectAtIndex:indexPath.row];
    
    NSString *nameMirror = info.title;
    NSString *bodyURL = info.FTPLink;
    
    self.detailViewController.title = nameMirror;
    self.detailViewController.FTPString = bodyURL;

    NSMutableArray *runDetails = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in info.runs) {
        //Make dictionary holding the video links and the corresponding picker item title
        NSDictionary *vidLinks = @{@"Vid":[dict objectForKey:@"Vid"],@"PickerItems":[dict objectForKey:@"SDVItems"]};
        RunDetail *detail = [[RunDetail alloc] initWithType:[dict objectForKey:@"Type"]
                                                  videoLinks:vidLinks
                                            andCommentsLink:[dict objectForKey:@"Comments"]];
        [runDetails addObject:detail];
    }
    
    self.detailViewController.runDetails = runDetails;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
