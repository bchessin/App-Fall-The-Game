//
//  Setup.h
//  AppFall3
//
//  Created by Brad Chessin on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppFall3ViewController.h"


@interface Setup : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate> {
	
	IBOutlet UIButton *choosePicture;
	IBOutlet UITextField *Name;
	NSString *nameString;
	IBOutlet UIImageView *proPicture;
	UIView *overlayView;
	
	//Player int
	

}

- (IBAction)doneSetup;
- (IBAction)doneKeyboard;
- (IBAction)camera;

- (IBAction)tempaction;

@end
