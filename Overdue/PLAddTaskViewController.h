//
//  PLAddTaskViewController.h
//  Overdue
//
//  Created by Peter Lehrer on 11/10/13.
//  Copyright (c) 2013 Peter Lehrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLTaskObject.h"

@protocol PLAddTaskViewControllerDelegate <NSObject>

@required
-(void)didCancel;
-(void)didAddTask:(PLTaskObject *)task;

@end

@interface PLAddTaskViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) id <PLAddTaskViewControllerDelegate> delegate;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;


@end
