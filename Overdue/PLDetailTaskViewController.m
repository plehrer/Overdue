//
//  PLDetailTaskViewController.m
//  Overdue
//
//  Created by Peter Lehrer on 11/10/13.
//  Copyright (c) 2013 Peter Lehrer. All rights reserved.
//

#import "PLDetailTaskViewController.h"

@interface PLDetailTaskViewController ()

@end

@implementation PLDetailTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.titleLabel.text = self.task.title;
	self.detailLabel.text = self.task.description;
	
	NSDate *date = self.task.date;
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSString *stringFromDate = [formatter stringFromDate:date];
	
	self.dateLabel.text = stringFromDate;
	
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([sender isKindOfClass:[UIBarButtonItem class]]) {
		if ([segue.destinationViewController isKindOfClass:[PLEditTaskViewController class]]) {
			PLEditTaskViewController *editTaskVC = segue.destinationViewController;
			editTaskVC.task = self.task;
			editTaskVC.delegate = self;
		}
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)editeditBarButtonItemPressed:(UIBarButtonItem *)sender {
	[self performSegueWithIdentifier:@"toEditTaskViewController" sender:sender];
}

#pragma mark - PLEditTaskViewController Delegate Method

- (void)didSaveTaskEdit:(PLTaskObject *)task {
	self.task = task;
	[self viewDidLoad];
	[self.delegate didSaveTaskDetail:task atIndex:self.index];
}
@end
