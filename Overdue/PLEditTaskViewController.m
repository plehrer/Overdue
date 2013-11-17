//
//  PLEditTaskViewController.m
//  Overdue
//
//  Created by Peter Lehrer on 11/10/13.
//  Copyright (c) 2013 Peter Lehrer. All rights reserved.
//

#import "PLEditTaskViewController.h"

@interface PLEditTaskViewController ()

@end

@implementation PLEditTaskViewController

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
	
	self.textField.text = self.task.title;
	self.textView.text = self.task.description;
	self.datePicker.date = self.task.date;
	
	// register delegate
	self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender {
	NSDictionary *dictionary = @{TASK_TITLE : self.textField.text, TASK_DESCRIPTION : self.textView.text, TASK_DATE : self.datePicker.date, TASK_COMPLETION : @(self.task.completion)};
	PLTaskObject *taskObject = [[PLTaskObject alloc] initWithData:dictionary];
	[self.delegate didSaveTaskEdit:taskObject];
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITexViewDelegate Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if ([text isEqualToString:@"\n"]) {
		[self.textView resignFirstResponder];
		return NO;
	}
	else {
		return YES;
	}
}


@end
