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
	if ([sender isKindOfClass:[UIBarButtonItem class]]) {
		if ([segue.destinationViewController isKindOfClass:[PLAddTaskViewController class]]) {
			PLAddTaskViewController *addTaskVC = [[PLAddTaskViewController alloc] init];
			addTaskVC = segue.destinationViewController;
			addTaskVC.delegate = self;
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



#pragma mark - PLAddTaskViewController Delegate

-(void)didCancel
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddTask:(PLTaskObject *)task
{
	NSLog(@"Got to didAddTask");
	[self.taskObjects addObject:task];
	NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK_OBJECTS_KEY] mutableCopy];
	if(!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
	[taskObjectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:task]];
	[[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:ADDED_TASK_OBJECTS_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self.tableView reloadData];
	[self dismissViewControllerAnimated:YES completion:nil];
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

@end
