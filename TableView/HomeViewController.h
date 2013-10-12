//
//  HomeViewController.h
//  TableView
//
//  Created by James Miller on 12/05/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UIAlertViewDelegate>

{

    IBOutlet UITextView *homeText;
}
- (void)checkForWIFIConnection;


@property(strong, nonatomic) UITextView *homeText;
@end
