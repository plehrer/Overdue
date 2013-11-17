//
//  PLDetailTaskViewController.h
//  Overdue
//
//  Created by Peter Lehrer on 11/10/13.
//  Copyright (c) 2013 Peter Lehrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLTaskObject.h"
#import "PLEditTaskViewController.h"

@protocol PLDetailTaskViewControllerDelegate <NSObject>

- (void)didSaveTaskDetail:(PLTaskObject *)task atIndex:(NSUInteger)index;

@end

@interface PLDetailTaskViewController : UIViewController <PLEditTaskViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) id <PLDetailTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) PLTaskObject *task;
@property (nonatomic, assign) NSUInteger index;

- (IBAction)editeditBarButtonItemPressed:(UIBarButtonItem *)sender;


@end
