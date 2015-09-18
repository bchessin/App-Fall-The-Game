//
//  Settings.m
//  AppFall3
//
//  Created by Brad Chessin on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Play.h"
#import <MediaPlayer/MediaPlayer.h>

#define K_SWITCH_KEY1 @"switch_key1"
#define K_SWITCH_KEY2 @"switch_key2"
#define K_SWITCH_KEY3 @"switch_key3"


@implementation Settings

@synthesize owner;
@synthesize mySwitch;
@synthesize customalertview;
@synthesize gamecenterbutton;


- (IBAction)changeimage:(id)sender {
	
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	
	picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	
	[self presentModalViewController:picker animated:YES];
	
}

/*
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
 [picker dismissModalViewControllerAnimated:YES];
 backgroundi.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
 }
 */

- (IBAction)back:(id)sender {
	
	//Save current state of UISwitches below
	NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
	
	UISwitch *switch1 = (UISwitch *)[self.view viewWithTag:1];
	[defaults setBool: switch1.on forKey: K_SWITCH_KEY1];
	[defaults synchronize];
	
	
	UISwitch *switch2 = (UISwitch *)[self.view viewWithTag:2];
	[defaults setBool: switch2.on forKey: K_SWITCH_KEY2];
	[defaults synchronize];
	
	
	UISwitch *switch3 = (UISwitch *)[self.view viewWithTag:3];
	[defaults setBool: switch3.on forKey: K_SWITCH_KEY3];
	[defaults synchronize];
	
	
	AppFall3ViewController *vc = [[AppFall3ViewController alloc] initWithNibName: @"AppFall3ViewController" bundle:nil];
	vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController: vc animated: YES];
	[vc release];
	vc.view.alpha = 1.0;
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	//sectionArray =  [[[NSArray arrayWithObjects:@"", nil] retain]autorelease];
	
	//return [sectionArray count];
	
	return 1;
	
}


- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	
	switch (indexPath.row) {
			
		case 2:
			return UITableViewCellAccessoryDisclosureIndicator;
			break;
			
		case 3:
			return UITableViewCellAccessoryDisclosureIndicator;
			break;
			
		case 4:
			return UITableViewCellAccessoryDisclosureIndicator;
			break;
			
	}
	return UITableViewCellAccessoryNone;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionHeader = nil;
	
	if(section == 0) {
		sectionHeader = nil;
	}
	return sectionHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	contentArray = [[NSArray arrayWithObjects:@"Sounds", @"Volume", @"Change Profile Picture", @"Calibrate Accelerometer", @"Change Background Picture", @"Tap to Start", @"Use My Face", nil] retain];
	return [contentArray count];
	
	[contentArray release];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Cell for row");
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
	// Configure the cell.
	cell.textLabel.text = [contentArray objectAtIndex:indexPath.row];
	switchView = [[UIView alloc] initWithFrame:CGRectMake(70, 5, 200, 100)];
	UISwitch *theSwitch = [[UISwitch alloc] initWithFrame:switchView.frame];
	[switchView addSubview:theSwitch];
	cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	
	if ([cell.textLabel.text isEqualToString:@"Sounds"]) {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[theSwitch setTag:1];
		[cell.contentView addSubview:switchView];
		
	}
	if ([cell.textLabel.text isEqualToString:@"Tap to Start"]) {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[theSwitch setTag:2]; 
		[cell.contentView addSubview:switchView];
	}
	if ([cell.textLabel.text isEqualToString:@"Use My Face"]) {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[theSwitch setTag:3];
		[cell.contentView addSubview:switchView];
	}
	if ([cell.textLabel.text isEqualToString:@"Volume"]) {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		// create a frame to hold the MPVolumeView
		MPVolumeView *mpVolumeViewParentView = [[[MPVolumeView alloc] initWithFrame:CGRectMake(100, 15, 200, 20)] autorelease];
		[mpVolumeViewParentView sizeToFit];
		[cell addSubview:mpVolumeViewParentView];
	}
	
	
	//Restore settings code
	NSUserDefaults* defaults  = [NSUserDefaults standardUserDefaults];
	UISwitch *switch1 = (UISwitch *)[self.view viewWithTag:1];
	UISwitch *switch2 = (UISwitch *)[self.view viewWithTag:2];
	UISwitch *switch3 = (UISwitch *)[self.view viewWithTag:3];
	switch1.on = [defaults boolForKey: K_SWITCH_KEY1];
	switch2.on = [defaults boolForKey: K_SWITCH_KEY2];
	switch3.on = [defaults boolForKey: K_SWITCH_KEY3];
	
	//Unrelated code for this method but still needed
	[switch1 addTarget:self action:@selector(uiswitchupdate) forControlEvents:UIControlEventValueChanged];
	[switch2 addTarget:self action:@selector(uiswitchupdate) forControlEvents:UIControlEventValueChanged];
	[switch3 addTarget:self action:@selector(uiswitchupdate) forControlEvents:UIControlEventValueChanged];
	
	//Check if this is the first time the view loaded
	if (viewnumber == 1) {
		NSLog(@"If statement called");
		UISwitch *switch1 = (UISwitch *)[self.view viewWithTag:1];
		UISwitch *switch2 = (UISwitch *)[self.view viewWithTag:2];
		switch1.on = YES;
		switch2.on = YES;
	}
	//End restore settings code
	
	[theSwitch release];
	[switchView release];
	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView2 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];	
	
	if (indexPath.row == 2)
	{
		
		UIAlertView *cp = [[UIAlertView alloc]
							 initWithTitle:@"Camera or Photos?"
							 
							 message:@"Where would you like to get the picture from?"
							 
							 delegate:self
							 
							 cancelButtonTitle:@"Dismiss"
							 
							 otherButtonTitles:@"Camera", @"Photos", nil];
		
		cp.tag = 10;
		
		
		
		[cp show];
		[cp release];
		
	
	}
	
	if (indexPath.row == 3)
	{
		[self.view addSubview:customalertview];
		//customalertview.backgroundColor = [UIColor clearColor];
		customalertview.center = self.view.superview.center;
		customalertview.layer.cornerRadius = 15;
		customalertview.backgroundColor = [UIColor blackColor];
		[calibrating startAnimating];
		hidealert = [NSTimer scheduledTimerWithTimeInterval:2.0/1.0 target:self selector:@selector(hidealertaction) userInfo:nil repeats:NO];
		
		//Add code for calibrating accelerometer
		
		
	}
	
	
	if (indexPath.row == 4)
	{
		
		UIAlertView *cp2 = [[UIAlertView alloc]
						   initWithTitle:@"Camera or Photos?"
						   
						   message:@"Where would you like to get the picture from?"
						   
						   delegate:self
						   
						   cancelButtonTitle:@"Dismiss"
						   
						   otherButtonTitles:@"Camera", @"Photos", nil];
		
		cp2.tag = 11;
		
		[cp2 show];
		[cp2 release];
		
	}
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
		NSLog(@"Button Index 0");
	}
	
	
	//Camera
	
	if (buttonIndex == 1) {
		
		NSLog(@"Button Index 1");
		
		if(alertView.tag == 10) {
			
			//Code
			[self UseCamera:YES];
			
		}
		
		if(alertView.tag == 11) {
			
			//Code
			//Background Image for Play view
			[self UseCamera:NO];
			
		}
		
	}
	
	//Photos
	
	if (buttonIndex == 2) {
		
		NSLog(@"Button Index 2");
		
		if(alertView.tag == 10) {
			
			NSLog(@"BI tag 10 called");
			
			//Code
			[self UseCameraRoll:YES];
			
		}
		
		if(alertView.tag == 11) {
			
			//Code
			//Background Image for Play view
			[self UseCameraRoll:NO];
			
		}
		
	}
	
}

- (void)UseCamera:(BOOL)value1 {
	
	NSLog(@"UseCamera Level 1");
	
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	[self presentModalViewController:picker animated:YES];
	
	if (value1 == YES) {
		
		[[picker navigationBar] setTag:20];
		NSLog(@"UseCamera Level 2 - YES");
		
		
	} else {
		//Code for alertView 2, etc...
		//Background Image for Play
		[[picker navigationBar] setTag:30];
		NSLog(@"UseCamera Level 2 - NO");
		
	}
	
	
}

- (void)UseCameraRoll:(BOOL)value2 {
	
	NSLog(@"Use Camera Roll Level1");
	
	UIImagePickerController *picker2 = [[UIImagePickerController alloc] init];
	picker2.delegate = self;
	picker2.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	[self presentModalViewController:picker2 animated:YES];
	
	if (value2 == YES) {
		
		NSLog(@"Use Camera Roll Level2 - YES");
		
		[[picker2 navigationBar] setTag:21];
		
		
	} else {
		//Code for alertView 2, etc...
		//BackgroundImage for Play
		NSLog(@"Use Camera Roll Level2 - NO");
		
		[[picker2 navigationBar] setTag:31];
		

	}
	
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
	if (picker.navigationBar.tag == 20) {
		//Do Camera Stuff
		//Set Background image in Play View
		NSLog(@"CameraNSLOG");
	}
	
	if (picker.navigationBar.tag == 21) {
		//Do Camera Roll Stuff
		NSLog(@"CameraRollNSLOG");
	}
	
	
	//Background Image for Play View below
	if (picker.navigationBar.tag == 30) {
		//Do Camera Stuff
		//Set Background image in Play View
		NSLog(@"BIFPV - CameraNSLOG");
		
		UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
		NSData*imgData = UIImagePNGRepresentation(image);
		NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
		[currentDefaults setObject:imgData forKey:@"BackgroundImage"];
		[currentDefaults synchronize];
		
	}
	
	if (picker.navigationBar.tag == 31) {
		//Do Camera Roll Stuff
		NSLog(@"BIFPV - CameraRollNSLOG");
		
		UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
		NSData*imgData = UIImagePNGRepresentation(image);
		NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
		[currentDefaults setObject:imgData forKey:@"BackgroundImage"];
		[currentDefaults synchronize];
		
	}
	
	[picker dismissModalViewControllerAnimated:YES];
	
	UIAlertView *dalert = [[UIAlertView alloc]
						   initWithTitle:@"Image Set"
						   
						   message:nil
						   
						   delegate:self
						   
						   cancelButtonTitle:@"Dismiss"
						   
						   otherButtonTitles:nil];
	
	[dalert show];
	[dalert release];
	
}



/*
 - (void)imagePickerController:(UIImagePickerController *)picker5 didFinishPickingMediaWithInfo:(NSDictionary *)info {
 UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
 UIImageView *view = [[UIImageView alloc] initWithImage:image];
 // Do what you want with the view, dismiss the picker, etc.
 }
 */

- (void)hidealertaction {
	
	[self.customalertview removeFromSuperview];
	[calibrating stopAnimating];
	
}


/*
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
	// Dismiss the picker
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
	
	// Get the image from the result
	UIImage* image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
	
	// Get the data for the image as a PNG
	NSData* imageData = UIImagePNGRepresentation(image);
	
	// Give a name to the file
	//	NSString* imageName = "MyImage.png";
	NSString *imageName = @"MyPic.png";
	
	// Now, we have to find the documents directory so we can save it
	// Note that you might want to save it elsewhere, like the cache directory,
	// or something similar.
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* documentsDirectory = [paths objectAtIndex:0];
	
	// Now we get the full path to the file
	NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
	
	// and then we write it out
	[imageData writeToFile:fullPathToFile atomically:NO];
	
	return;
}
 */

- (IBAction)info {
	
	UIAlertView *info = [[UIAlertView alloc]
						 initWithTitle:@"About App Fall"
						 
						 message:@"App Fall is made by iBrad Apps \n Questions/Comments: ibradapps@yahoo.com \n For the latest news and apps by iBrad Apps go to http://www.iBradApps.com"
						 
						 delegate:self
						 
						 cancelButtonTitle:@"Dismiss"
						 
						 otherButtonTitles:nil];
	
	
	
	[info show];
	[info release];
	
	
}



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

- (IBAction)uiswitchupdate {
	
	NSLog(@"UISwitchUpdate");
	
	UISwitch *switch1 = (UISwitch *)[self.view viewWithTag:1];
	UISwitch *switch2 = (UISwitch *)[self.view viewWithTag:2];
	UISwitch *switch3 = (UISwitch *)[self.view viewWithTag:3];
	
	NSString *value = @"ON";
	NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
	//switch 1
	if(!switch1.on){
		value = @"OFF";
		[userPreferences setObject:value forKey:@"stateOfSwitch"];
	}
	[userPreferences setObject:value forKey:@"stateOfSwitch"];
	//switch 2
	NSString *value2 = @"ON";
	if(!switch2.on){
		value2 = @"OFF";
		[userPreferences setObject:value2 forKey:@"stateOfSwitch2"];
	}
	[userPreferences setObject:value2 forKey:@"stateOfSwitch2"];
	//switch 3
	NSString *value3 = @"ON";
	if(!switch3.on){
		value3 = @"OFF";
		[userPreferences setObject:value3 forKey:@"stateOfSwitch3"];
	}
	[userPreferences setObject:value3 forKey:@"stateOfSwitch3"];
	
	
}

- (IBAction)restoreSettings {
	
	UIAlertView *ralert = [[UIAlertView alloc]
							 initWithTitle:@"Settings Restored"
							 
							 message:nil
							 
							 delegate:self
							 
							 cancelButtonTitle:@"Dismiss"
							 
							 otherButtonTitles:nil];
	
	[ralert show];
	[ralert release];
	
	
	
	UISwitch *switch1 = (UISwitch *)[self.view viewWithTag:1];
	UISwitch *switch2 = (UISwitch *)[self.view viewWithTag:2];
	UISwitch *switch3 = (UISwitch *)[self.view viewWithTag:3];
	[switch1 setOn:YES animated:YES];
	[switch2 setOn:YES animated:YES];
	[switch3 setOn:NO animated:YES];
	
	//Restore Picture on Play View
	Play *PV = [[Play alloc] init];
	UIImage *image = [UIImage imageNamed:@"Graph-Paper.png"];
	[PV.backgroundImage setImage:image];
	[PV release];
	
}

/*
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	
	acceleration.x = xvalue;
	acceleration.y = yvalue;
	acceleration.z = zvalue;
	
}
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIAccelerometer *Accelerometer = [UIAccelerometer sharedAccelerometer];
	Accelerometer.delegate = self;
	
	viewnumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"ViewCount"];
	
	viewnumber = viewnumber +1;
	
	[[NSUserDefaults standardUserDefaults] setInteger:viewnumber forKey:@"ViewCount"];
	
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
}


- (void)dealloc {
    [super dealloc];
	[customalertview release];
	[owner release];
	[mySwitch release];
}


@end
