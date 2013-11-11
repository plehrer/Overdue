//
//  PLViewController.m
//  Overdue
//
//  Created by Peter Lehrer on 11/10/13.
//  Copyright (c) 2013 Peter Lehrer. All rights reserved.
//

#import "PLViewController.h"
#import "PLTaskObject.h"

@interface PLViewController ()

@end

@implementation PLViewController

#pragma mark - Lazy Instantiation
-(NSMutableArray *)taskObjects {
	if (!_taskObjects) {
		_taskObjects = [[NSMutableArray alloc] init];
	}
	return _taskObjects;
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([sender isKindOfClass:[UIBarButtonItem class]]) {
		if ([segue isKindOfClass:[PLAddTaskViewController class]]) {
			PLAddTaskViewController *addTaskVC = [[PLAddTaskViewController alloc] init];
			addTaskVC = segue.destinationViewController;
			addTaskVC.delegate = self;
		}
	}
}

#pragma mark - PLAddTaskViewController Delegate

-(void)didCancel
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddTask:(PLTaskObject *)task
{
	[self.taskObjects addObject:task];
	NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK_OBJECTS_KEY] mutableCopy];
	if(!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
	[taskObjectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:task]];
	[[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:ADDED_TASK_OBJECTS_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBAction

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender {
}

- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender {
}

#pragma mark - Helper Methods
// Convert our task object to NSDictionary so it can be store as a property list
// @( ) takes primitive bool and converts it to an NSNumber object
-(NSDictionary *)taskObjectAsAPropertyList:(PLTaskObject *)taskObject
{
	NSDictionary *dictionary = @{TASK_TITLE : taskObject.title, TASK_DESCRIPTION : taskObject.description, TASK_DATE : taskObject.date, TASK_COMPLETION : @(taskObject.completion)};
	return dictionary;
}

@end
