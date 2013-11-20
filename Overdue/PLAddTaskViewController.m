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
	self.textView.delegate = self;
	self.textField.delegate = self;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate Methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if ([string isEqualToString:@"\n"]) {
		[self.textField resignFirstResponder];
		return NO;
	}
	else {
		return YES;
	}
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

#pragma mark - IBAction

- (IBAction)addTaskButtonPressed:(UIButton *)sender {
	NSDictionary *dictionary = @{TASK_TITLE : self.textField.text, TASK_DESCRIPTION : self.textView.text, TASK_DATE : self.datePicker.date, TASK_COMPLETION : @(NO)};
	PLTaskObject *taskObject = [[PLTaskObject alloc] initWithData:dictionary];
	[self.delegate didAddTask:taskObject];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
	[self.delegate didCancel];
}

#pragma mark - Helper Method

-(PLTaskObject *)getTaskObject
{
	NSDictionary  *taskDictionary = @{TASK_TITLE : self.textField.text, TASK_DESCRIPTION : self.textView.text, TASK_DATE : self.datePicker, TASK_COMPLETION : @NO};
	PLTaskObject *taskObject = [[PLTaskObject alloc] initWithData:taskDictionary];
	return taskObject;
}
@end
