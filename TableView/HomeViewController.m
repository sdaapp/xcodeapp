//
//  HomeViewController.m
//  TableView
//
//  Created by James Miller on 12/05/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import "HomeViewController.h"
#import "Reachability.h"

@interface HomeViewController ()
@end

@implementation HomeViewController
@synthesize homeText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Home", @"Home");
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self checkReachability];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        homeTextBottomConstraint.constant = 0; // This constraint is only needed on iOS 7.
    }
}

-(void)viewDidAppear:(BOOL)animated{
    

    
    NSURL *url = [[NSURL alloc] initWithString:@"http://sdaapp.net/Text/hText.txt"];
    
    NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    homeText.text = string;
    
    
}

-(void)checkReachability
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if(internetStatus == NotReachable) {
        UIAlertView *errorView;
        
        errorView = [[UIAlertView alloc]
                     initWithTitle: NSLocalizedString(@"Network error", @"Network error")
                     message: NSLocalizedString(@"Internet connection not found. Check your internets.", @"Network error")
                     delegate: self
                     cancelButtonTitle: NSLocalizedString(@"OK. I will", @"Network error") otherButtonTitles: nil];
        
        [errorView show];
    }
    [self checkForWIFIConnection];
}
-(void)checkForWIFIConnection
{

    Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    if (netStatus!=ReachableViaWiFi)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No WIFI", @"AlertView")
                                                            message:NSLocalizedString(@"You have a complete lack of Wifi. It's advised", @"AlertView")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Thanks for the tip!", @"AlertView")
                                                  otherButtonTitles: nil];
        [alertView show];
    }
    

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
