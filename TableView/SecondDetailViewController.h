//
//  SecondDetailViewController.h
//  TableView
//
//  Created by luke on 27/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@class RunDetail;

@interface SecondDetailViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{

    IBOutlet UITextView *runnersInfo;
    IBOutlet UIPickerView *secondPicker;
    NSUInteger selectedRow;
    CGRect runnersInfoOriginalFrame;

}
@property (strong, nonatomic) UIView *myView;
@property (strong, nonatomic) RunDetail *run;
@property(nonatomic,strong) MPMoviePlayerController *mediaPlayer;

@end
