//
//  Singleton.m
//  AppFall3
//
//  Created by Brad Chessin on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"


@implementation Singleton

static Singleton *_instance;
//static Facebook *fb;


+ (Singleton *) instance{
	if (!_instance) {
		_instance = [[Singleton alloc] init];
	}
	return _instance;
}

- (id) init{
	if (self = [super init]) {
	}
	return self;
}

- (void) dealloc{
	[super dealloc];
}

/*
+ (Facebook *) sharedFacebookHandle {
	if (fb == nil) {
		fb = [[Facebook alloc] init];
	}
	
	return fb;
}
 */

@end
