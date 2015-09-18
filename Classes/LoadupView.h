//
//  LoadupView.h
//  AppFall3
//
//  Created by Brad Chessin on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppFall3ViewController.h"

@interface LoadupView : UIViewController {
	
	IBOutlet UIActivityIndicatorView *loading;
	
	NSTimer *switchviews;
	
	/*
	//Game Center Connection Alert
	UILabel *label;
	UIActivityIndicatorView *progress;
	UIImageView *xmark;
	UIImageView *checkmark;
	UIAlertView *gccheck;
	 */
	

}

- (void)endview;

@end
