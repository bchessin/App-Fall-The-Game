//
//  Play.h
//  AppFall3
//
//  Created by Brad Chessin on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppFall3ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "AppFall3AppDelegate.h"
#import "GameOver.h"
#import <MediaPlayer/MediaPlayer.h>

@class GameOver;

@interface Play : UIViewController <UIAccelerometerDelegate, AVAudioPlayerDelegate, UIAlertViewDelegate, MPMediaPickerControllerDelegate, UIActionSheetDelegate> {
	
	//Scoring part
	int score;
	IBOutlet UILabel *scorelabel;
	
	AVAudioPlayer *player;
	
	IBOutlet UIImageView *myImageView;
	
	IBOutlet UIButton *Phonecharacter;
	
	//Accelerometer
	CGPoint AccelPoint;
	
	//Lives
	
	IBOutlet UIImageView *heart;
	
	//Countdown Stuff
	NSTimer *timer;
	int mainInt;
	
	CGPoint *spawnarea;
	
	UIImageView *imageFromFile;
	
	CGRect bounds;
	
	CGRect *leftframe;
	CGRect *rightframe;
	
	CGPoint *firstpoint;
	CGPoint *secondpoint;
	
	GameOver *gameOverViewController;
	
	//Images
	UIImageView *image1;
	UIImageView *image2;
	
	UIImageView *x2picture;
	UIImageView *x2small;
	
	CADisplayLink *displayLink;
	
	//Label animation
	int firstnumber;
	int secondnumber;
	
	//TTS button
	UIButton *tts;
	
	IBOutlet UIView *PauseView;
	
	//PauseMenu Items
	MPMusicPlayerController *musicPlayer;
	
	//Animation (Fire)
	UIImageView *fire;
	IBOutlet UIButton *spikes;
	
	//Cross Screen Character Stuff
	CGFloat centerY;
	CGFloat centerY2;
	
	//App Icon Array
	NSMutableArray *appIcons;
	
	//NSTimers for spikes and fire animations
	NSTimer *SpikeTimer;
	NSTimer *FireTimer;
	
	//Method firing int
	int CollisionInt;
	
	//Spawn Image Stuff
	UIImageView *spawnImages;
	int randomX;
	
	//BOOLs
	BOOL codeFired;
	
	//Background Image
	IBOutlet UIImageView *backgroundImage;
	
	//Gravity
	float playerSpeed;
	
	//Stop CADisplayLink
	BOOL stopCAL;
	
	//ActionSheet
	UIActionSheet *actionsheet;
	
	//Whos Playing NSInteger
	NSInteger personPlaying;
	
}

- (IBAction)PauseMenus;

- (IBAction)tempbutton;

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;

@property (nonatomic) CGPoint *spawnarea;

@property(nonatomic) CGPoint center;

@property (nonatomic, retain) UIButton *Phonecharacter;

@property (nonatomic, retain) UIImageView *imageFromFile;

@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) UIImageView *myImageView;

@property (nonatomic, retain) GameOver *gameOverViewController;

@property(nonatomic, readonly) CGRect screenBounds;


//Animation methods, and checking if the Phone Character collided with anything
- (void)checkcollision;
- (void)animations1;
- (void)animations2;
- (void)stopanimation;

//Tap to Start Action (VDL if TTS is enabled)
- (void)taptostart;

//PauseMenu Items
- (IBAction)back;

//Music Actions
- (IBAction)openMediaPicker:(id)sender;
- (IBAction)playOrPauseMusic:(id)sender;
- (IBAction)stopmusic:(id)sender;

//Pause Action (Available anywhere in app)
- (IBAction)PauseMenus;
- (void)UnPauseAlert;

-(void)pauseLayer:(CALayer*)layer;
-(void)resumeLayer:(CALayer*)layer;

- (void)pauseALL:(BOOL)val;

- (void)spawnSystem;

@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;

@end
