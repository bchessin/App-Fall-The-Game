//
//  LoadupView.m
//  AppFall3
//
//  Created by Brad Chessin on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoadupView.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Setup.h"


@implementation LoadupView


- (void)endview {
	
	AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSLog(@"Universal int: %i", appDelegate.launchCount);
	
	if (appDelegate.launchCount == 1) {
		
		Setup *sp = [[Setup alloc] initWithNibName: @"Setup" bundle:nil];
		[self presentModalViewController: sp animated: NO];
		[sp release];
		
	}
	else {
		
		AppFall3ViewController *vc = [[AppFall3ViewController alloc] initWithNibName: @"AppFall3ViewController" bundle:nil];
		[self presentModalViewController: vc animated: NO];
		[vc release];
		
	}
	
	[loading stopAnimating];
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	//initialize variable
	NSUInteger tapCount =0;
	
	//run through a loop of all touches
	
	for (UITouch *touch in touches)
	{
		//assign tapCount based on the current touch in the loop
		tapCount = [touch tapCount];	
		
		//use tapCount in your switch statement 
		//though if you only have 2 conditions if/else would work just as well
		switch (tapCount) {
			case 1:
				
				//Post thread, why the switching views is undeclared unless there is a function line
				
				//Invalidate NSTimer
				[switchviews invalidate];
				
				//Load view
				AppFall3ViewController *vc = [[AppFall3ViewController alloc] initWithNibName: @"AppFall3ViewController" bundle:nil];
				[self presentModalViewController:vc animated: NO];
				[vc release];
				
				break;
			default:
				break;
		}
	}
	
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[loading startAnimating];
	
	switchviews = [[NSTimer scheduledTimerWithTimeInterval:5.00 target:self selector:@selector(endview) userInfo:nil repeats:NO] retain];
	
	/*
	//Game Center UIAlertView 
	gccheck = [[UIAlertView alloc]
			   initWithTitle:@"Establishing connection with Game Center"
			   
			   message:@"\n\n"
			   
			   delegate:self
			   
			   cancelButtonTitle:@"Dismiss"
			   
			   otherButtonTitles:nil];
	
	//Activity Indicator
	progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(210, 70, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [gccheck addSubview:progress];
    [progress startAnimating];
	
	//UILabel
	CGRect rect = CGRectMake(60, 75, 170, 23);
	label = [[UILabel alloc] initWithFrame:rect];
	[label setTag:01];
	[label setText: @"Connecting..."];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont systemFontOfSize:20];
	[label setTextColor: [UIColor whiteColor]];
	[gccheck addSubview:label];
	
	[NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(dismiss:) userInfo:gccheck repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkInternet:) userInfo:gccheck repeats:NO];
	
	[gccheck show];
	[gccheck release];
	 */
	
}

/*
- (void)checkInternet:(NSTimer *)theTimer {
	
	NSLog(@"checkInternet:(NSTimer*)theTimer - Called");
	
	[progress stopAnimating];
	
	Reachability *r = [Reachability reachabilityWithHostName:@"www.maxqdata.com"];
	
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	
	
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
	{
		NSLog(@"No internet IF");
		//No Internet
		CGRect rect = CGRectMake(60, 75, 170, 23);
		label = [[UILabel alloc] initWithFrame:rect];
		[label setText:@"Connection Failed"];
		//Show X Mark
		UIImage *oneimage = [UIImage imageNamed:@"Rxmark.png"];
		xmark = [[UIImageView alloc] initWithImage:oneimage];
		xmark.frame = CGRectMake(185, 64, 54, 50);
		[gccheck addSubview:xmark];
		[xmark release]; 
		
	}
	
	else 
		
	{
		NSLog(@"Internet IF");
		//Internet
		[label setText:@"Connected"];
		//Show Check Mark
		UIImage *twoimage = [UIImage imageNamed:@"Checkmark.png"];
		checkmark = [[UIImageView alloc] initWithImage:twoimage];
		checkmark.frame = CGRectMake(185, 64, 54, 50);
		[gccheck addSubview:checkmark];
		[checkmark release]; 
		
	}
	
}


//Dismissing the alertview
- (void)dismiss:(NSTimer *)theTimer {
	[[theTimer userInfo] dismissWithClickedButtonIndex:0 animated:YES];
	[theTimer invalidate];
	theTimer = nil;
	
}
 */

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
	[loading release];
	[switchviews invalidate];
	[switchviews release];
	
}


@end
