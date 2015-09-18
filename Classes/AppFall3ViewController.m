//
//  AppFall3ViewController.m
//  AppFall3
//
//  Created by Brad Chessin on 10/2/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AppFall3ViewController.h"
#import "LoadupView.h"
#import "Setup.h"

#define SOURCETYPE UIImagePickerControllerSourceTypeCamera

#define kAnimationDuration 3.5
#define ARC4RANDOM_MAX      0x100000000

@implementation AppFall3ViewController

@synthesize myImageView;
@synthesize image2;
@synthesize overlayView;
@synthesize playbutton, settingsbutton;
@synthesize flashimage;
@synthesize profarray;
@synthesize statsbutton;
@synthesize myImageViewleft;


-(IBAction)playView {
	
	
	Play *pla = [[Play alloc] initWithNibName: @"Play" bundle:nil];
	pla.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController: pla animated: YES];
	[pla release];
	
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1)
	{
		
		//actions
		UIImagePickerController *picker = [[UIImagePickerController alloc] init];
		
		// Set the image picker source to the camera:
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
		
		// Hide the camera controls:
		picker.showsCameraControls = YES;
		picker.navigationBarHidden = NO;
		
		// Make the view full screen:
		picker.wantsFullScreenLayout = YES;
		picker.cameraViewTransform = CGAffineTransformScale(picker.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
		
		// Now incert our overlay view (it has to be here cuz it's a modal view):
		picker.cameraOverlayView = overlayView;
		
		// Show the picker:
		[self presentModalViewController:picker animated:YES];
		[picker release];
		
		
	}
}

-(IBAction)settingsView

{
	
	Settings *se = [[Settings alloc] initWithNibName: @"Settings" bundle:nil];
	se.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController: se animated: YES];
	[se release];
	
}

- (IBAction)gameover {
	
	GameOver *Gao = [[GameOver alloc] initWithNibName: @"GameOver" bundle:nil];
	Gao.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController: Gao animated: YES];
	[Gao release];
	
}


-(IBAction)statsView {
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:FALSE forKey:@"NewCell"];
	[defaults synchronize];
	
	Statistics *sa = [[Statistics alloc] initWithNibName: @"Statistics" bundle:nil];
	sa.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController: sa animated: YES];
	[sa release];
	
}

-(IBAction)addProfile {
	
	AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.ViewCount +1;

	//Go to Setup View
	Setup *se = [[Setup alloc] initWithNibName: @"Setup" bundle:nil];
	se.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController: se animated: YES];
	[se release];
	
}

-(NSString*) replaceBadWords:(NSString*)userText {
    NSArray  *badWordsArray= [NSArray arrayWithObjects:@"ass", @"tit", @"tits", @"vag", @"penis", @"pen1s", @"@ss", @"titties", @"fuck", @"fucker", @"fucka", @"cum", @"sperm", @"asshole", @"assh0le", @"69", @"96", @"asshol3", @"dick", @"d1ck", @"azz", @"shit", @"cunt", @"kunt", @"nigger", @"nigga", @"faggot", @"fag", @"faggy", @"fagot", nil];
	
    for(NSString* s in badWordsArray){
		userText =[userText stringByReplacingOccurrencesOfString:s withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0,[userText length])];
    }
	
    return userText;
}

- (void)textFieldDidChange :(NSNotification *)notif {
	NSString *tmp = [self replaceBadWords:_txtName.text];
	if(![tmp isEqualToString:_txtName.text])
		_txtName.text = tmp;
}

- (void)viewDidAppear:(BOOL)animated {
	
	[_txtName becomeFirstResponder];
	_txtName.placeholder = @"Name";
	
}

- (void)doubletime1 {
	
	//Speed of animation
	double durationValue = (((double)arc4random() / ARC4RANDOM_MAX) * 4.0f) + 2;
	NSString *imageName = [imageArray objectAtIndex: (arc4random() % [imageArray count])];
	[self animations1:durationValue :imageName];
	
}

- (void)doubletime2 {
	
	//Speed of animation
	double durationValue = (((double)arc4random() / ARC4RANDOM_MAX) * 4.0f) + 2;
	NSString *imageName = [imageArray objectAtIndex: (arc4random() % [imageArray count])];
	[self animations2:durationValue :imageName];
	
}

- (void)animations1:(float)durationValue:(NSString*)imageName {
	
	NSString *imagepath1 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName];
	NSLog(@"The random image: %@", imageName);
	self.myImageView.image = [UIImage imageWithContentsOfFile:imagepath1];
	
	CABasicAnimation *theAnimation;
	theAnimation = [CABasicAnimation animationWithKeyPath: @"transform.translation.y"];
	theAnimation.duration = durationValue;	
	//theAnimation.repeatCount = 1;
	theAnimation.autoreverses = NO;
	theAnimation.removedOnCompletion = NO; 
	theAnimation.fillMode = kCAFillModeForwards;
	
	theAnimation.fromValue = [NSNumber numberWithFloat: (self.myImageView.frame.size.height / 2) + (self.view.frame.size.height - self.myImageView.center.y)];
	theAnimation.toValue = [NSNumber numberWithFloat: 0.0 - (self.myImageView.frame.origin.y + self.myImageView.frame.size.height)];
	
	//[self.myImageView.layer addAnimation:theAnimation forKey: @"animateLayer"];
	[theAnimation setValue:@"Animation1" forKey:@"animateLayer"];
	[[self.myImageView layer] addAnimation:theAnimation forKey:nil];
	
	NSLog(@"Animation Picture: %@", self.myImageView.image);
    
	
}

- (void)animations2:(float)durationValue:(NSString*)imageName {
	
	NSString *imagepath1 = [[[NSBundle mainBundle] resourcePath]  stringByAppendingPathComponent:imageName];
	NSLog(@"The random image2: %@", imageName);
	self.myImageViewleft.image = [UIImage imageWithContentsOfFile:imagepath1];
	
	CABasicAnimation *theAnimation2;
	theAnimation2 = [CABasicAnimation animationWithKeyPath: @"transform.translation.y"];
	theAnimation2.duration = durationValue;	
	//theAnimation2.repeatCount = 1;
	theAnimation2.autoreverses = NO;
	theAnimation2.removedOnCompletion = NO; 
	theAnimation2.fillMode = kCAFillModeForwards;
	
	theAnimation2.fromValue = [NSNumber numberWithFloat: (self.myImageViewleft.frame.size.height / 2) + (self.view.frame.size.height - self.myImageViewleft.center.y)];
	theAnimation2.toValue = [NSNumber numberWithFloat: 0.0 - (self.myImageViewleft.frame.origin.y + self.myImageViewleft.frame.size.height)];
	
	//[self.myImageViewleft.layer addAnimation:theAnimation2 forKey: @"animateLayer2"];
	[theAnimation2 setValue:@"Animation2" forKey:@"animateLayer"];
	[[self.myImageViewleft layer] addAnimation:theAnimation2 forKey:nil];
	
	NSLog(@"Animation Picture2: %@", self.myImageViewleft.image);
    
	
}


- (void)animationDidStop:(CABasicAnimation *)theAnimation finished:(BOOL)flag {
	
	NSLog(@"animationDidStop");
	
	NSString* value = [theAnimation valueForKey:@"animateLayer"];
    if ([value isEqualToString:@"Animation1"])
    {
		//... Your code here ...
		NSLog(@"Right Animation Did Stop");
		
		//Right animation did stop
		//Random float between 0 and 1 and call animation method
		double callValue = (((double)arc4random() / ARC4RANDOM_MAX) * 0.0f) + 1;
		[NSTimer scheduledTimerWithTimeInterval:callValue target:self selector:@selector(doubletime1) userInfo:nil repeats:NO];
		
		return;
    }
	
	
    if ([value isEqualToString:@"Animation2"])
    {
		//... Your code here ...
		NSLog(@"Left Animation Did Stop");
		
		//Left animation did stop
		//Random float between 0 and 1 and call animation method
		double callValue2 = (((double)arc4random() / ARC4RANDOM_MAX) * 0.0f) + 1;
		[NSTimer scheduledTimerWithTimeInterval:callValue2 target:self selector:@selector(doubletime2) userInfo:nil repeats:NO];
		
		return;
    }
	
	
	/*
	if (theAnimation == [[self.myImageView layer] animationForKey:@"animateLayer"]) {
		
		NSLog(@"Right Animation Did Stop");
		
		//Right animation did stop
		//Random float between 0 and 1 and call animation method
		double callValue = (((double)arc4random() / ARC4RANDOM_MAX) * 0.0f) + 1;
		
		[NSTimer scheduledTimerWithTimeInterval:callValue target:self selector:@selector(doubletime1) userInfo:nil repeats:NO];
		
	}
	
	if (theAnimation == [[self.myImageViewleft layer] animationForKey:@"animateLayer2"]) {
	
		NSLog(@"Left Animation Did Stop");
		
		//Left animation did stop
		//Random float between 0 and 1 and call animation method
		double callValue2 = (((double)arc4random() / ARC4RANDOM_MAX) * 0.0f) + 1;
		
		[NSTimer scheduledTimerWithTimeInterval:callValue2 target:self selector:@selector(doubletime2) userInfo:nil repeats:NO];
		
	}
	*/
	
}
 


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	imageArray = [NSArray arrayWithObjects:@"Gamecenter2.png", @"AppStoreIcon2.png", nil];
	
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"Name1"]){
										   
	}
	
	//Make view have black background
	[self.view setBackgroundColor:[UIColor blackColor]];
	//Create Black SubView behind the main view
	CGRect myFrame = CGRectMake(0, 0, 320, 480);
	UIView *myView = [[UIView alloc] initWithFrame:myFrame];
	myView.backgroundColor = [UIColor blackColor];
	[self.view insertSubview:myView atIndex:0];
	[myView release];
	 
	//Bad Word Protector
	[_txtName setDelegate:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:@"UITextFieldTextDidChangeNotification" object:_txtName];	
	
	//Call animation methods
	[self doubletime1];
	[self doubletime2];
	
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[myImageView release];
	[_txtName release];
	[overlayView release];
	[image2 release];
	[flashimage release];
	[profarray release];
	[imageArray release];
	
}

@end
