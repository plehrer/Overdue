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
	
	// retrieve stored tasks
	NSArray *myTaskObjectsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK_OBJECTS_KEY];
	for (NSDictionary *dictionary in myTaskObjectsAsPropertyLists) {
		PLTaskObject *task = [self taskObjectForDictionary:dictionary];
		[self.taskObjects addObject:task];
	}
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// If add task button is pressed
	if ([sender isKindOfClass:[UIBarButtonItem class]]) {
		if ([segue.destinationViewController isKindOfClass:[PLAddTaskViewController class]]) {
			PLAddTaskViewController *addTaskVC = [[PLAddTaskViewController alloc] init];
			addTaskVC = segue.destinationViewController;
			addTaskVC.delegate = self;
		}
	}
	
	// If accessory button is pressed
	if ([sender isKindOfClass:[NSIndexPath class]]) {
		if ([segue.destinationViewController isKindOfClass:[PLDetailTaskViewController class]]) {
			PLDetailTaskViewController *detailVC = segue.destinationViewController;
			NSIndexPath *indexPath = sender;
			detailVC.task = self.taskObjects[indexPath.row];
			detailVC.index = indexPath.row;
			detailVC.delegate = self;
		}
	}
}

#pragma mark - UITableViewDatasource Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	PLTaskObject *task = [self.taskObjects objectAtIndex:indexPath.row];
	cell.textLabel.text = task.title;
	// format date string and assign to cell detail
	NSDate *date = task.date;
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSString *stringFromDate = [formatter stringFromDate:date];
	cell.detailTextLabel.text = stringFromDate;
	
	// check if task is overdue
	BOOL overdue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
	if (!overdue && !task.completion) {
		cell.backgroundColor = [UIColor yellowColor];
	}
	else if (overdue && !task.completion) {
		cell.backgroundColor = [UIColor redColor];
	}
	else cell.backgroundColor = [UIColor greenColor];
	
	return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.taskObjects count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

#pragma mark - UITableView Delegate methods

// When the user taps on a row
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// retrieve the task from the task objects array
	PLTaskObject *task = self.taskObjects[indexPath.row];
	
	[self updateCompletionOfTask:task forIndexPath:indexPath];
	
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self.taskObjects removeObjectAtIndex:indexPath.row];
		
		NSMutableArray *newSavedTaskObjects = [[NSMutableArray alloc] init];
		
		for (PLTaskObject *task in self.taskObjects) {
			[newSavedTaskObjects addObject:[self taskObjectAsAPropertyList:task]];
		}
		
		[[NSUserDefaults standardUserDefaults] setObject:newSavedTaskObjects forKey:ADDED_TASK_OBJECTS_KEY];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}

}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"toDetailViewControllerSegue" sender:indexPath];
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
	
	// Fixes problem where added task not appearing without stopping and starting program.
	[self.tableView reloadData];
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PLDetailTaskViewController Delegate Method

-(void)didSaveTaskDetail:(PLTaskObject *)task atIndex:(NSUInteger)index{
	
	[self.taskObjects replaceObjectAtIndex:index withObject:task];
	
	NSMutableArray *newSavedTaskObjects = [[NSMutableArray alloc] init];
	
	for (PLTaskObject *task in self.taskObjects) {
		[newSavedTaskObjects addObject:[self taskObjectAsAPropertyList:task]];
	}
	
	[[NSUserDefaults standardUserDefaults] setObject:newSavedTaskObjects forKey:ADDED_TASK_OBJECTS_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	
	[self.tableView reloadData];
	
	
}

#pragma mark - IBAction

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender {
}

- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender {
	[self performSegueWithIdentifier:@"toAddTaskViewController" sender: sender];
}

#pragma mark - Helper Methods
// Convert our task object to NSDictionary so it can be store as a property list
// @( ) takes primitive bool and converts it to an NSNumber object
-(NSDictionary *)taskObjectAsAPropertyList:(PLTaskObject *)taskObject
{
	NSDictionary *dictionary = @{TASK_TITLE : taskObject.title, TASK_DESCRIPTION : taskObject.description, TASK_DATE : taskObject.date, TASK_COMPLETION : @(taskObject.completion)};
	return dictionary;
}

-(PLTaskObject *)taskObjectForDictionary:(NSDictionary *)dictionary
{
	PLTaskObject *task = [[PLTaskObject alloc] initWithData:dictionary];
	return task;
}

- (BOOL)isDateGreaterThanDate:(NSDate*)date and:(NSDate*)toDate {
	if ([date timeIntervalSince1970] > [toDate timeIntervalSince1970]) {
		return YES;
	}
	else return NO;
}

// Mark the task object's completion property to YES and store it, then reload the table view.
-(void)updateCompletionOfTask:(PLTaskObject *)task forIndexPath:(NSIndexPath *)indexPath {
		
	// Retrieve property lists array from NSUserDefaults
	NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK_OBJECTS_KEY] mutableCopy];
	
	if (!taskObjectsAsPropertyLists) {
		taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
	}
	// remove the task object dictionary
	[taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
	
	// update the task object to show that it has been completed
	if (task.completion == YES) task.completion = NO;
	else task.completion = YES;
	
	// convert it to dictionary format and add re insert it back the property lists array at the speficied index
	[taskObjectsAsPropertyLists insertObject:[self taskObjectAsAPropertyList:task] atIndex:indexPath.row];
	

	// save it
	[[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:ADDED_TASK_OBJECTS_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];

	[self.tableView reloadData];
	
}

@end
