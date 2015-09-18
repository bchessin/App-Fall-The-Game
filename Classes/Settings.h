//
//  Settings.h
//  AppFall3
//
//  Created by Brad Chessin on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppFall3ViewController.h"

#define CAMERA_TRANSFORM_X 1
#define CAMERA_TRANSFORM_Y 1

#define SCREEN_WIDTH  320
#define SCREEN_HEIGHT 425


@interface Settings : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIAccelerometerDelegate> {
	
	NSArray *contentArray;
	NSArray *sectionArray;
	
	IBOutlet UITableView *tableView;
	
	id owner;
	
	IBOutlet UISwitch *mySwitch;
	
	//IBOutlet UISwitch *theSwitch;
	
	IBOutlet UIView *customalertview;
	IBOutlet UIActivityIndicatorView *calibrating;
	
	IBOutlet UIBarButtonItem *gamecenterbutton;
	
	IBOutlet NSTimer *hidealert;
	
	UIView *switchView;
	
	//int for # of time view showed
	int viewnumber;
	
	double xvalue;
	double yvalue;
	double zvalue;

}

@property (nonatomic, retain) IBOutlet UIView *customalertview;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *gamecenterbutton;

@property (nonatomic, retain) id owner;

@property (nonatomic, retain) UISwitch *mySwitch;

- (void)restoreSettings;

- (IBAction)back:(id)sender;

- (IBAction)changeimage:(id)sender;

- (IBAction)info; 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

//Camera and Photo methods
- (void)UseCamera:(BOOL)value1;
- (void)UseCameraRoll:(BOOL)value2;

- (IBAction)restoreSettings;


@end
