//
//  DetailViewController.m
//  TableView
//
//  Created by James Miller on 21/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import "DetailViewController.h"
#import "RunDetail.h"
#import "SecondDetailViewController.h"

@interface DetailViewController ()
- (void)updateData;
@end

@implementation DetailViewController

@synthesize FTPString = _FTPString;
@synthesize runDetails = _runDetails;
@synthesize descriptionString = _descriptionString;

@synthesize secondDetailController = _secondDetailController;

#pragma mark - Managing set properties



- (void)setFTPString:(NSString *)newString {
    if (_FTPString != newString) {
        _FTPString = newString;
        [self updateData];
    }

}

- (void)setRunDetails:(NSArray *)newDetails
{
    if (_runDetails != newDetails) {
        _runDetails = newDetails;
        [detailTable reloadData];
    }
}

- (void)setDescriptionString:(NSString *)newDescLabel
{
    if (_descriptionString != newDescLabel)
        _descriptionString = newDescLabel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

- (void)updateData
{
    
    if (self.FTPString) {
        //Here we start the background loading
        dispatch_async(dispatch_queue_create("LoadTxt", NULL), ^{
            NSError *error;
            //Here we load the text
            NSString *text = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:self.FTPString]
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
            //We've got the text now, got back to foreground
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (error) NSLog(@"Something went wrong: %@",error);
                else {
                    body.text = text;
                    [body.layer setBorderColor: [[UIColor darkGrayColor] CGColor]];
                    [body.layer setBorderWidth:1.0];
                    body.layer.cornerRadius = 2;
                    body.clipsToBounds = YES;
                }
                //We've now successfully set the text
            
            });
        });
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.runDetails count];
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
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize: 15];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        
        
    }
    
    RunDetail *detail = [self.runDetails objectAtIndex:indexPath.row];
    cell.textLabel.text = detail.type;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.secondDetailController) {
        self.secondDetailController = [[SecondDetailViewController alloc] initWithNibName:@"SecondDetailViewController" bundle:nil];
    }
    
    self.secondDetailController.run = [self.runDetails objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:self.secondDetailController animated:YES];
}

@end





