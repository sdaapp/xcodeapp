//
//  AboutViewController.m
//  TableView
//
//  Created by James Miller on 12/05/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import "AboutViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>


@interface AboutViewController ()

@end

@implementation AboutViewController

    
    @synthesize scroller;
    ADBannerView *_aBanner;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Info", @"Info");
    }
    return self;
}


- (IBAction)donate:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=C9TTCLA8A2MNU"]];
}

- (IBAction)followT:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/lukesadler"]];

}
- (IBAction)tweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"#SDAApp Check it out on iOS - it's free"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (IBAction)failbook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                NSLog(@"Cancelled");
                
            } else
                
            {
                NSLog(@"Done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        //Adding the Text to the facebook post value from iOS
        [controller setInitialText:@"Check out the SDA App on iOS - it's free!"];
        [controller addImage:[UIImage imageNamed:@"spotlight80.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }
    
}
    
- (IBAction)report:(id)sender {
    
    UIAlertView *errorView;
    
    errorView = [[UIAlertView alloc]
                 initWithTitle: NSLocalizedString(@"Logging", @"Logging")
                 message: NSLocalizedString(@"Please enter as much detail as you can about the error/ fault you have experienced. Thank you", @"Logging")
                 delegate: self
                 cancelButtonTitle: NSLocalizedString(@"OK", @"Logging") otherButtonTitles: nil];
    errorView.tag = 101;
    
    
      [errorView show];
}

    - (IBAction)issues:(id)sender {
        
        
        UIAlertView *errorView;
        
        errorView = [[UIAlertView alloc]
                  initWithTitle: NSLocalizedString(@"Issues", @"Issues")
                  message: NSLocalizedString(@"You're about to be transfereed to Safari. Make sure you come back...", @"Issues")
                  delegate: self
                  cancelButtonTitle: NSLocalizedString(@"I will", @"Issues") otherButtonTitles: nil];
        errorView.tag = 102;
        
        [errorView show];
    }


    

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (alertView.tag == 101) {
            
                NSLog(@"ok");
                
                // Email Subject
                NSString *emailTitle = @"ERROR LOG";
                // Email Content
                NSString *messageBody = @"";
                // To address
                NSArray *toRecipents = [NSArray arrayWithObject:@"speeddemosarchive.app@gmail.com"];
                
                MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                mc.mailComposeDelegate = self;
                [mc setSubject:emailTitle];
                [mc setMessageBody:messageBody isHTML:NO];
                [mc setToRecipients:toRecipents];
                
                // Present mail view controller on screen
                [self presentViewController:mc animated:YES completion:NULL];
            }
        else if (alertView.tag == 102)
            {
                   NSLog(@"ok");
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sdaapp.net/issues.rtf"]];
      
}
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)viewDidLoad
{
    
        [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    scroller.contentSize = CGSizeMake(320, 1180);

    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        _aBanner = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    } else {
        _aBanner = [[ADBannerView alloc] init];
    }
    _aBanner.delegate = self;
    [self.view addSubview:_aBanner];
    
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"didFailToReceiveAdWithError %@", error);

    [_aBanner removeFromSuperview];
}


- (void)viewDidLayoutSubviews
{
    CGRect contentFrame = self.view.bounds, bannerFrame = CGRectZero;
    
     bannerFrame.size = [_aBanner sizeThatFits:contentFrame.size];
    
    if (_aBanner.bannerLoaded) {
        contentFrame.size.height -= bannerFrame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    _aBanner.frame = contentFrame;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end







