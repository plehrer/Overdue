//
//  PLTaskObject.m
//  Overdue
//
//  Created by Peter Lehrer on 11/11/13.
//  Copyright (c) 2013 Peter Lehrer. All rights reserved.
//

#import "PLTaskObject.h"

@implementation PLTaskObject

//Overide init method
-(id)init
{
	self = [self initWithData:nil];
	
	return self;
}

-(id)initWithData:(NSDictionary *)data
{
	self = [super init];
	
	self.title = data[TASK_TITLE];
	self.description = data[TASK_DESCRIPTION];
	self.date = data[TASK_DATE];
	self.completion = [data[TASK_COMPLETION] boolValue];
	
	return self;
}


@end
