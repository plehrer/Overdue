//
//  PLDetailTaskViewController.h
//  Overdue
//
//  Created by Peter Lehrer on 11/10/13.
//  Copyright (c) 2013 Peter Lehrer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLDetailTaskViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editeditBarButtonItemPressed:(UIBarButtonItem *)sender;


@end
