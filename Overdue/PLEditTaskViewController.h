//
//  PLEditTaskViewController.h
//  Overdue
//
//  Created by Peter Lehrer on 11/10/13.
//  Copyright (c) 2013 Peter Lehrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLTaskObject.h"

@protocol PLEditTaskViewControllerDelegate <NSObject>

- (void)didSaveTaskEdit:(PLTaskObject *)task;

@end

@interface PLEditTaskViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) id <PLEditTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) PLTaskObject *task;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
