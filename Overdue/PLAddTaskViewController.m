//
//  PLAddTaskViewController.m
//  Overdue
//
//  Created by Peter Lehrer on 11/10/13.
//  Copyright (c) 2013 Peter Lehrer. All rights reserved.
//

#import "PLAddTaskViewController.h"

@interface PLAddTaskViewController ()

@end

@implementation PLAddTaskViewController

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
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTaskButtonPressed:(UIButton *)sender {
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
}

#pragma mark - Helper Method

-(PLTaskObject *)getTaskObject
{
	NSDictionary  *taskDictionary = @{TASK_TITLE : self.textField.text, TASK_DESCRIPTION : self.textView.text, TASK_DATE : self.datePicker, TASK_COMPLETION : @NO};
	PLTaskObject *taskObject = [[PLTaskObject alloc] initWithData:taskDictionary];
	return taskObject;
}
@end
