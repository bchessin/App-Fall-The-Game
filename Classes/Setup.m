//
//  Setup.m
//  AppFall3
//
//  Created by Brad Chessin on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Setup.h"
#import <QuartzCore/QuartzCore.h>

#define SOURCETYPE UIImagePickerControllerSourceTypeCamera

@implementation Setup

- (IBAction)tempaction {
	
	AppFall3ViewController *vc = [[AppFall3ViewController alloc] initWithNibName: @"AppFall3ViewController" bundle:nil];
	vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:vc animated: YES];
	[vc release];
	
}

- (IBAction)doneSetup {
	
	AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	if (appDelegate.ViewCount == 1) {
		
		[prefs setObject:nameString forKey:@"Name1"];
		
	}
	if (appDelegate.ViewCount == 2) {
		
		[prefs setObject:nameString forKey:@"Name2"];
		
	}
	if (appDelegate.ViewCount == 3) {
		
		[prefs setObject:nameString forKey:@"Name3"];
		
	}
	if (appDelegate.ViewCount == 4) {
		
		[prefs setObject:nameString forKey:@"Name4"];
		
	}
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithString: @"profilepicture.png"]];
	NSData* data = UIImageJPEGRepresentation(proPicture.image, 1.0);
	[data writeToFile:path atomically:YES];
	
	if (Name.text == nil) {
		
		UIAlertView *namealert = [[UIAlertView alloc]
								  initWithTitle:@"Name field empty"
								  
								  message:@"There is no name entered in the field"
								  
								  delegate:self
								  
								  cancelButtonTitle:@"Dismiss"
								  
								  otherButtonTitles:nil];
		
		
		
		[namealert show];
		[namealert release];
		
	}
	else if (proPicture.image == nil) {
		
		UIAlertView *pa = [[UIAlertView alloc]
						   initWithTitle:@"No picture entered"
						   
						   message:@"There is picture entered"
						   
						   delegate:self
						   
						   cancelButtonTitle:@"Dismiss"
						   
						   otherButtonTitles:nil];
		
		
		
		[pa show];
		[pa release];
		
	}
	
	if ((proPicture.image != nil) && (Name.text != nil)) {
		
		AppFall3ViewController *vc = [[AppFall3ViewController alloc] initWithNibName: @"AppFall3ViewController" bundle:nil];
		vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		[self presentModalViewController:vc animated: YES];
		[vc release];
		
	}
	
	
}

- (IBAction)doneKeyboard {
	nameString = Name.text;
}

- (IBAction)camera {
	
	//[self resignFirstResponder];
	
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	
	if ([UIImagePickerController isSourceTypeAvailable:SOURCETYPE]) {
		//Camera Devices
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
		[[picker navigationBar] setTag:1];
		
	}
	else {
		//Non Camera Devices
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[[picker navigationBar] setTag:2];
		
	}
	
	[self presentModalViewController:picker animated:YES];
	[picker release];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {	
	NSLog(@"imagePickerController finished called");
	
	CALayer *imageLayer = [proPicture layer];
	[imageLayer setMasksToBounds:YES];
	[imageLayer setCornerRadius:10.0];
	
	if ([UIImagePickerController isSourceTypeAvailable:SOURCETYPE]) {
		[choosePicture setTitle:@"Retake Picture" forState:UIControlStateNormal];
	}
	else {
		[choosePicture setTitle:@"Rechoose Picture" forState:UIControlStateNormal];
	}
	
	UIImage *pictureprofile = [info objectForKey:UIImagePickerControllerOriginalImage];
	[proPicture setImage:pictureprofile];
	
	if (picker.navigationBar.tag == 1) {
		//Do Camera Stuff
		//Set Background image in Play View
		NSLog(@"CameraNSLOG");
	}
	
	if (picker.navigationBar.tag == 2) {
		//Do Camera Roll Stuff
		NSLog(@"CameraRollNSLOG");
	}
	
	[picker dismissModalViewControllerAnimated:YES];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSLog(@"appDelegate ViewCount:%i", appDelegate.ViewCount);
	
	if (appDelegate.ViewCount == 1) {
		
	}
	if (appDelegate.ViewCount == 2) {
		
	}
	if (appDelegate.ViewCount == 3) {
		
	}
	if (appDelegate.ViewCount == 4) {
		
	}
	
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"Name1"] && [defaults objectForKey:@"Name2"] && [defaults objectForKey:@"Name3"] && [defaults objectForKey:@"Name4"]) {
		
		NSLog(@"NSUserDefaults called in Setup");
		
		AppFall3ViewController *vc = [[AppFall3ViewController alloc] initWithNibName: @"AppFall3ViewController" bundle:nil];
		[self presentModalViewController:vc animated: NO];
		[vc release];
						
		UIAlertView *toomany = [[UIAlertView alloc]
								initWithTitle:@"Max amount of profiles"
								
								message:@"App Fall only allows 4 profiles. Once you delete one, then you can make a new one."
								
								delegate:self
								
								cancelButtonTitle:@"Dismiss"
								
								otherButtonTitles:nil];
		
		
		
		[toomany show];
		[toomany release];
		
	}
	
	Name.delegate = self;
	
	NSLog(@"Universal int: %i", appDelegate.launchCount);
	
	//Might be launchCount
	if (appDelegate.ViewCount == 1) {
		
		//AlertView
		UIAlertView *setupinfo = [[UIAlertView alloc]
								 initWithTitle:@"Info"
								 
								 message:@"Here you can setup your profile. Enter your name and then take a picture to represent yourself."
								 
								 delegate:self
								 
								 cancelButtonTitle:@"Dismiss"
								 
								 otherButtonTitles:nil];
		
		
		
		[setupinfo show];
		[setupinfo release];
		
	}
	
	//Future: if launch count is 2, its player two, 3, its player three, etc....
	
	if ([UIImagePickerController isSourceTypeAvailable:SOURCETYPE]) {
	}
	else {
		[choosePicture setTitle:@"Choose Image" forState:UIControlStateNormal];
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[overlayView release];
	
}


@end
