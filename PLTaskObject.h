//
//  PLTaskObject.h
//  Overdue
//
//  Created by Peter Lehrer on 11/11/13.
//  Copyright (c) 2013 Peter Lehrer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLTaskObject : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completion;

#pragma mark - Designate Initializer Method
-(id)initWithData:(NSDictionary *)data;

@end
