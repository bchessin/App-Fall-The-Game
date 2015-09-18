//
//  Play.m
//  AppFall3
//
//  Created by Brad Chessin on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Play.h"
#import <AudioToolbox/AudioToolbox.h>

#define kAnimationDuration 3.0
#define kDrillsAnimationDuration 1

#define kGravity 0.195

@implementation Play

@synthesize Phonecharacter, myImageView, player, center, spawnarea, imageFromFile, screenBounds, gameOverViewController, musicPlayer, backgroundImage;

- (IBAction)openMediaPicker:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES; // this is the default   
    [self presentModalViewController: mediaPicker animated: YES];
    [mediaPicker release];
} 

// Media picker delegate methods
- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
	// We need to dismiss the picker
	[self dismissModalViewControllerAnimated:YES];
	
	// Assign the selected item(s) to the music player and start playback.
	[self.musicPlayer stop];
	[self.musicPlayer setQueueWithItemCollection:mediaItemCollection];
	[self.musicPlayer play];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    // User did not select anything
    // We need to dismiss the picker
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)playOrPauseMusic:(id)sender {
	
	[self.musicPlayer play];
	
}

- (IBAction)stopmusic:(id)sender {
	
	[self.musicPlayer pause];
	
}

- (IBAction)tempbutton {
	
	score = score +1;
	
}


- (void)checkcollision {
	
	if (stopCAL == NO) {
		
		//NSLog(@"character: %f, %f", Phonecharacter.center.x, Phonecharacter.center.y );
		//NSLog(@"playerSpeed: %f", playerSpeed);
		
		scorelabel.text = [NSString stringWithFormat:@"%i" , score];
		
		//If the character hits the fire
		if (CollisionInt == 0) {
			
			
			if (CGRectIntersectsRect(Phonecharacter.frame, fire.frame)) {
				
				UIImage *blood = [UIImage imageNamed:@"Blood.png"];
				UIImageView *bloodcharacter1 = [[UIImageView alloc] initWithImage:blood];
				bloodcharacter1.frame = Phonecharacter.frame;
				[self.view addSubview:bloodcharacter1];
				[bloodcharacter1 release]; 
				
				Phonecharacter.enabled = NO;
				
				//Vibrate
				AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
				
				//Go to Game Over screen
				[self performSelector:@selector(gamedone) withObject:nil afterDelay:2.0];
				
				//Make old character hidden and disabled
				Phonecharacter.enabled = NO;
				[Phonecharacter removeFromSuperview];
				[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
				
				//Update CollisionInt
				CollisionInt +=1;
				
				//Game Review Picture #2
				UIGraphicsBeginImageContext(self.view.bounds.size);
				[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
				UIImage *imageName2 = UIGraphicsGetImageFromCurrentImageContext();
				UIGraphicsEndImageContext();
				
				//Resize the image and then share it afterwards
				CGRect area = CGRectMake(0, 0, 145, 170);
				CGSize size = area.size;
				UIGraphicsBeginImageContext(size);
				[imageName2 drawInRect:area];
				
				//Make screenshot then save to nsuserdefaults
				UIImage *playerplay2 = UIGraphicsGetImageFromCurrentImageContext();
				UIGraphicsEndImageContext();
				NSData *imgData2 = UIImageJPEGRepresentation(playerplay2,1.0);
				NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
				[currentDefaults2 setObject:imgData2 forKey:@"GameImage2"];
				[currentDefaults2 synchronize];
				
			}
			
		}
		
		if (CollisionInt == 0) {
			
			
			//If the character hits the fire
			if (CGRectIntersectsRect(Phonecharacter.frame, spikes.frame)) {
				
				UIImage *blood = [UIImage imageNamed:@"Blood.png"];
				UIImageView *bloodcharacter2 = [[UIImageView alloc] initWithImage:blood];
				bloodcharacter2.frame = Phonecharacter.frame;
				[self.view addSubview:bloodcharacter2];
				[bloodcharacter2 release]; 
				
				Phonecharacter.enabled = NO;
				
				//Vibrate
				AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
				
				//Go to Game Over screen
				[self performSelector:@selector(gamedone) withObject:nil afterDelay:2.0];
				
				//Make old character hidden and disabled
				[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
				[Phonecharacter removeFromSuperview];
				Phonecharacter.enabled = NO;
				
				//Update CollisionInt
				CollisionInt +=1;
				
				NSLog(@"ScreenShot 2");
				
				//Game Review Picture #2
				UIGraphicsBeginImageContext(self.view.bounds.size);
				[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
				UIImage *imageName1 = UIGraphicsGetImageFromCurrentImageContext();
				UIGraphicsEndImageContext();
				
				//Resize the image and then share it afterwards
				CGRect area = CGRectMake(0, 0, 145, 170);
				CGSize size = area.size;
				UIGraphicsBeginImageContext(size);
				[imageName1 drawInRect:area];
				
				//Make screenshot then save to nsuserdefaults
				UIImage *playerplay1 = UIGraphicsGetImageFromCurrentImageContext();
				UIGraphicsEndImageContext();
				NSData *imgData1 = UIImageJPEGRepresentation(playerplay1,1.0);
				NSUserDefaults *currentDefaults1 = [NSUserDefaults standardUserDefaults];
				[currentDefaults1 setObject:imgData1 forKey:@"GameImage1"];
				[currentDefaults1 synchronize];
				
				NSLog(@"ScreenShotImage: %@", playerplay1);
				
			}
		}
		
		if (CGRectIntersectsRect(myImageView.frame, Phonecharacter.frame)) {
			
			//action when character and moving image touch
			//Below is the code if the switch in settings is on or off
			NSString *myvalue= [[NSUserDefaults standardUserDefaults] stringForKey:@"stateOfSwitch"];
			
			if([myvalue compare:@"ON"] == NSOrderedSame){
				[self.player play];
			}
			else {
				
			}
			
			//Below here put in the code to start the score and updating the label
			score += 1;
			
			CABasicAnimation *theAnimation2;	
			theAnimation2=[CABasicAnimation animationWithKeyPath: @"transform.translation.y"];
			theAnimation2.duration = 3.4;
			theAnimation2.repeatCount = 0;
			theAnimation2.autoreverses = NO;
			theAnimation2.removedOnCompletion = YES; 
			theAnimation2.fillMode = kCAFillModeForwards;
			theAnimation2.fromValue = [NSNumber numberWithFloat: self.view.frame.size.height];
			theAnimation2.toValue = [NSNumber numberWithFloat: 0.0];	
			[self.Phonecharacter.layer addAnimation:theAnimation2 forKey: @"animateLayer"];	
			
			
		}
		
		if (CGRectIntersectsRect(scorelabel.frame, Phonecharacter.frame)) {
			
			//We bring the label to the front
			[self.view bringSubviewToFront:(UILabel *)scorelabel];
			scorelabel.textColor = [UIColor whiteColor];
			
		}
		
		
		if (CGRectIntersectsRect(x2small.frame, Phonecharacter.frame)) {
			
			//Make animation for label - Make it wiggle and animate numbers to the x2 score
			
			[UILabel beginAnimations:nil context:nil];
			[UILabel setAnimationDuration:2.00];
			[UILabel setAnimationRepeatAutoreverses:YES];
			[UILabel setAnimationRepeatCount:0];
			
			//If you want label to not wiggle as much just lower the numbers
			scorelabel.transform = CGAffineTransformMakeRotation(69);
			scorelabel.transform = CGAffineTransformMakeRotation(-69);
			
			[UILabel commitAnimations];
			
			//Label animation for the changing of the score
			//scorelabel.text = firstnumber;
			//scorelabel.text = secondnumber *2;
			
			
			[self performSelector:@selector(stopanimation) withObject:nil afterDelay:2.00];
			
			//Score
			
			score *= 2;
			
			//Add animation for x2 score picture
			
			[x2picture setAlpha:0.0];
			x2picture.frame = CGRectMake(84, 40, 156, 74);
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.5];
			[x2picture setAlpha:75.0];
			[UIView commitAnimations];
		
			
		}
		
	}
}


- (void)stopanimation {
	
	scorelabel.transform = CGAffineTransformMakeRotation(0);
	[scorelabel.layer removeAllAnimations];
	
}


/*
 - BOOL putPowerUp = (arc4random()%10 == 0);
 if(putPowerUp){
 // add the powerup as a subview,
 // or set powerup=YES on the platform object
 }
 */

- (void) awakeFromNib {
	score = 0;
	CollisionInt = 0;
	
}

- (void)gamedone {	
	
	AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSDate *now = [NSDate date];
	[appDelegate.Dates addObject:now];
	
	stopCAL = YES;
	
	[[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"GameCenterScore"];
	
	GameOver *gaov = [[GameOver alloc] initWithNibName: @"GameOver" bundle:nil];
	[self presentModalViewController: gaov animated: YES];
	[gaov release];
	
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


- (void)spawntime {
	
	//[self randomimage];
	
	//NSString *imageName = [self randomimage];
	
	//oneFilename.center = CGPointMake( randomX, 9);
	
	//randomX = arc4random()%320;
	
	/*
	 NSString *imageName = [self randomimage];
	 UIImageView *imageFromFile = [[UIImageView alloc] init];
	 int randomX =  arc4random() %320;
	 imageFromFile.image = [UIImage imageNamed:imageName];
	 imageFromFile.center = CGPointMake(randomX, 9);
	 */
	
	appIcons = [[NSMutableArray alloc] initWithObjects:@"Gamecenter2.png", @"AppStoreIcon2.png", nil];
	NSString *imageName = [appIcons objectAtIndex: (arc4random() % [appIcons count])];
	NSString *imagepath1 = [[[NSBundle mainBundle] resourcePath]  stringByAppendingString:imageName];
	myImageView.image = [UIImage imageWithContentsOfFile:imagepath1];
	
	spawnImages = [UIImageView alloc];
	randomX = arc4random()%320;
	spawnImages.center = CGPointMake(randomX, -50);
	
}

- (IBAction)back {
	
	[PauseView removeFromSuperview];
	
	//UnPause
	[self pauseALL:NO];
	
	
}

- (IBAction)PauseMenus {
	
	//AddSubview method here and add alpha value too (0.70). Also pause any game function (sounds, animations, scores, etc...)
	[self.view addSubview:PauseView];
	
	//Pause the Game stuff
	[self pauseALL:YES];
	
	
	
}

- (void)pauseALL:(BOOL)val {
	
	if(val==YES){
        [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
        [self pauseLayer:self.view.layer];
	}else{
		
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
        [self resumeLayer:self.view.layer];
	}
	
}


-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
} 

- (void)taptostart {
	
	//Image Array
	appIcons = [[NSMutableArray alloc] initWithObjects:@"Gamecenter2.png", @"AppStoreIcon2.png", nil];
	
	playerSpeed = 0.0f;
	
	scorelabel.adjustsFontSizeToFitWidth = YES;
	
	[spikes setAdjustsImageWhenHighlighted:NO];
	
	self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
	
	[tts setHidden:YES];
	
	[Phonecharacter setAdjustsImageWhenHighlighted:NO];
	
	[scorelabel setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:26]];
	
	//We refresh the screen
	
	displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(checkcollision)];
	[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	
	
	//[self randomimage];
	//NSLog(@"View Did Load = %@", [self randomimage]);
	
	//[NSTimer scheduledTimerWithTimeInterval:3.00 target:self selector:@selector(spawntime) userInfo:nil repeats:YES];
	
	//Countdown
	//countdown = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(methodtoshowimage) userInfo:nil repeats:NO];
	
	//[self spawntime];
	
	myImageView.center = CGPointMake(myImageView.center.x+0 , myImageView.center.y+10);
	
	CABasicAnimation *theAnimation;	
	theAnimation=[CABasicAnimation animationWithKeyPath: @"transform.translation.y"];
	theAnimation.duration = kAnimationDuration;	
	theAnimation.repeatCount = INFINITY;
	theAnimation.autoreverses = NO;
	theAnimation.removedOnCompletion = NO; 
	theAnimation.fillMode = kCAFillModeForwards;
	
	theAnimation.fromValue = [NSNumber numberWithFloat: (self.myImageView.frame.size.height / 2) + (self.view.frame.size.height - self.myImageView.center.y)];
	theAnimation.toValue = [NSNumber numberWithFloat: 0.0 - (self.myImageView.frame.origin.y + self.myImageView.frame.size.height)];
	
	//theAnimation.fromValue = [NSNumber numberWithFloat: (self.imageFromFile.frame.size.height / 2) + (self.view.frame.size.height - self.imageFromFile.center.y)];
	//theAnimation.toValue = [NSNumber numberWithFloat: 0.0 - (self.imageFromFile.frame.origin.y + self.imageFromFile.frame.size.height)];
	
	[self.myImageView.layer addAnimation:theAnimation forKey: @"animateLayer"];
	
	myImageView.frame = [[myImageView.layer presentationLayer] frame];
	
	AccelPoint.x = 160;
	AccelPoint.y = 240;
	
	UIAccelerometer *Accelerometer = [UIAccelerometer sharedAccelerometer];
	Accelerometer.delegate = self;
	Accelerometer.updateInterval = 0.10f/4.0f;
	
	//audio 
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Pop" ofType:@"m4a"];
    NSLog(@"path: %@", path);
    NSURL *file = [[NSURL alloc] initFileURLWithPath:path];
	
    AVAudioPlayer *p = [[AVAudioPlayer alloc]
                        initWithContentsOfURL:file error:nil];
    [file release];
	
    self.player = p;
    [p release];
	
    [player prepareToPlay];
    [player setDelegate:self];
	
	mainInt = 3;
	
}


- (void)animations1 {
	
	//Fire animation
	// create the view that will execute our animation
	fire = [[UIImageView alloc] initWithFrame:CGRectMake(0, 449, 320, 31)];
	
	// load all the frames of our animation
	fire.animationImages = [NSArray arrayWithObjects:    
							[UIImage imageNamed:@"Flames1.png"],
							[UIImage imageNamed:@"Flames2.png"],
							[UIImage imageNamed:@"Flames3.png"], nil];
	
	// all frames will execute in 1.75 seconds
	fire.animationDuration = 1;
	// repeat the annimation forever
	fire.animationRepeatCount = 0;
	// start animating
	[fire startAnimating];
	// add the animation view to the main window 
	[self.view addSubview:fire];
	
	
}

- (void)animations2 {
	
	//Drills animation
	//Create drills animation
	[UIView beginAnimations:@"DrillAnimation" context:@selector(animationDidStart:)];
	[UIView setAnimationDuration:kDrillsAnimationDuration];
	spikes.center = CGPointMake(spikes.center.x+0 , spikes.center.y+27);
	[UIView setAnimationRepeatCount:1];
	[UIView setAnimationRepeatAutoreverses:YES];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(finishAnimation:finished:context:)];
	[UIView commitAnimations];
	
}

- (void)finishAnimation:(NSString *)animationId finished:(BOOL)finished context:(void *)context {
    // Whatever you need to do after the animation is done
	[UIView beginAnimations:@"DrillAnimation2" context:@selector(animationDidStart:)];
	[UIView setAnimationDuration:kDrillsAnimationDuration];
	spikes.center = CGPointMake(spikes.center.x+0 , spikes.center.y-27);
	[UIView setAnimationRepeatCount:1];
	[UIView setAnimationRepeatAutoreverses:YES];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animations2)];
	[UIView commitAnimations];
}

- (void)spawnSystem {
	
	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Load Background Image
    // Load NSData-object from NSUserDefault
	NSData *imageData = (NSData *) [[NSUserDefaults standardUserDefaults] objectForKey:@"BackgroundImage"];
	if (imageData != nil) {
		backgroundImage.image = [UIImage imageWithData:imageData];
	}
	else if (imageData == nil){
		NSLog(@"imageData == nil");
		UIImage *image = [UIImage imageNamed: @"Graph-Paper.png"];
		[backgroundImage setImage:image];
	}
	 
	CollisionInt = 0;
	
	//Array of Names
	AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	int arraynum = [appDelegate.Names count];
	NSLog(@"arraynum:%i", [appDelegate.Names count]);
	if (arraynum >= 2) {
		actionsheet = [[UIActionSheet alloc] initWithTitle:@"Who's Playing?"  delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
		for (NSMutableArray * tmp in appDelegate.Names) 
			[actionsheet addButtonWithTitle:[tmp objectAtIndex:0]];
		[actionsheet showInView:self.view];
		[actionsheet release];
	}
	
	[self animations2];
	[self animations1];
	
	//Later on get UISwitch from settings to set if it is on, if it is call code below, if it isn't just call [self taptostart];
	NSString *_value= [[NSUserDefaults standardUserDefaults] stringForKey:@"stateOfSwitch2"];
	
	if([_value compare:@"ON"] == NSOrderedSame){
		//If the UISwitch is on
		tts = [UIButton buttonWithType:UIButtonTypeCustom];
		[tts addTarget:self 
				action:@selector(taptostart)
	  forControlEvents:UIControlEventTouchUpInside];
		[tts setImage:[UIImage imageNamed:@"Tap-Screen.png"] forState:UIControlStateNormal];
		tts.frame = CGRectMake(0, 0, 320, 480);
		tts.alpha = 0.85;
		[tts setAdjustsImageWhenHighlighted:NO];
		[self.view addSubview:tts];
		
	}
	else {
		[self taptostart];
	}
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	//Delete NSUserDefaults then set the NSInteger to the buttonIdex then save it to GameOver to make a new cell in Stats
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PlayingPerson"];
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"theDate"];
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"GameCenterScore"];
	personPlaying = buttonIndex;
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setInteger:personPlaying forKey:@"PlayingPerson"];
	NSDate *now = [NSDate date];
	[[NSUserDefaults standardUserDefaults] setObject:now forKey:@"theDate"];
}
		

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceration {
	
	AccelPoint.x += (acceration.x*50);
	
	if (AccelPoint.x < 0) {
		AccelPoint.x = 320;
	}
	
	if (AccelPoint.x > 320) {
		AccelPoint.x = 0;
	}
	
	// insert other code from above here, 
	// but not character.center = AccelPoint; yet
	
	// this is the number to adjust; negative because gravity is down,
	// higher number = pulls down faster
	playerSpeed += 0.066;
	
	AccelPoint.y += playerSpeed;
	
	//now we can set that character center
	Phonecharacter.center = AccelPoint;
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)UnPauseAlert {
	
	//Call Pause method until the user clicks Start on uialertview
	[self pauseALL:YES];
	
	
	//This Alert will be show whenever the app is coming back from the background
	if (PauseView.superview == nil) { 
		UIAlertView *upalert = [[UIAlertView alloc]
								initWithTitle:@"Get Ready"
								
								message:nil
								
								delegate:self
								
								cancelButtonTitle:nil
								
								otherButtonTitles:@"Start", nil];
		upalert.tag = 5;
		
		[upalert show];
		[upalert release];
		
	}
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		
		if(alertView.tag == 5) {
			
			[self pauseALL:NO];
			
		}
		
	}
	
}

- (void)viewWillAppear:(BOOL)animated {
	
	NSLog(@"View Will Appear Called");
	
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UnPauseAlert) 
                                                 name:@"UPAlert"
                                               object:nil];
	
}

- (void)viewWillDisappear:(BOOL)animated {
	
	NSLog(@"View Will DisAppear Called");
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
}


- (void)dealloc {
    [super dealloc];
	[Phonecharacter release];
	[imageFromFile release];
	[player release];
	[myImageView release];
	[x2picture release];
	[x2small release];
	[musicPlayer release];
	
}

@end
