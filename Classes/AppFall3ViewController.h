//
//  AppFall3ViewController.h
//  AppFall3
//
//  Created by Brad Chessin on 10/2/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Play.h"
#import "Settings.h"
#import "Statistics.h"
#include "TargetConditionals.h"

#define CAMERA_TRANSFORM_X 1
#define CAMERA_TRANSFORM_Y 1

#define SCREEN_WIDTH  320
#define SCREEN_HEIGHT 425

@class Play;

@interface AppFall3ViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {

	//UIButtons
	IBOutlet UIButton *playbutton;
	IBOutlet UIButton *settingsbutton;
	IBOutlet UIButton *statsbutton;
	
	//ImageView Animation on right
	IBOutlet UIImageView *myImageView;
	
	//ImageView Animation on right
	IBOutlet UIImageView *myImageViewleft;
	
	IBOutlet UIImageView *image2;
	
	UIView *overlayView;
	
	UITextField *_txtName;
	NSString *name;
    
    int index1;
    int index2;
    
    UIAlertView *alertone;
	
	//Images Array
	NSArray *imageArray;

}

-(IBAction)playView;
-(IBAction)settingsView;
-(IBAction)statsView;
-(IBAction)addProfile;

@property (nonatomic, retain) IBOutlet UIView *overlayView;
@property (nonatomic, retain) IBOutlet UIImageView *myImageView;
@property (nonatomic, retain) IBOutlet UIImageView *myImageViewleft;

@property (nonatomic, retain) UIImageView *image2;

@property (nonatomic, retain) IBOutlet UIButton *playbutton;
@property (nonatomic, retain) IBOutlet UIButton *settingsbutton;
@property (nonatomic, retain) IBOutlet UIButton *statsbutton;


@property (nonatomic, retain) NSArray *profarray;

@property (nonatomic, retain) UIImageView *flashimage;

- (IBAction)gameover;

- (void)doubletime1;
- (void)doubletime2;
- (void)animations1:(float)durationValue:(NSString*)imageName;
- (void)animations2:(float)durationValue:(NSString*)imageName;


@end

