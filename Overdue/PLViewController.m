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

#pragma mark - IBAction

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender {
}

- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender {
}
@end
