//
//  AppFall3AppDelegate.h
//  AppFall3
//
//  Created by Brad Chessin on 10/2/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"
#import "LoadupView.h"
#import "FBConnect.h"
#import "FBLoginDialog.h"

@class AppFall3ViewController;
@class LoadupView;
@class Play;
@class FacebookAPIViewController;

@interface AppFall3AppDelegate : NSObject <UIApplicationDelegate, UIAlertViewDelegate, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, GameCenterManagerDelegate> {
    UIWindow *window;
    LoadupView *viewController2;
	
	Play *pl;
	
	NSString *gameCenterEnabled;
	NSString *gameCenterPlayerID;
	NSString *gameCenterPlayerAlias;
	
	GameCenterManager *gameCenterManager;
	
	int launchCount;
	
	FacebookAPIViewController *viewController;
	
	//Array's for Statistics
	NSMutableArray *Score;
	NSMutableArray *Names;
	NSMutableArray *Dates;
	NSMutableArray *ProfilePictures;
	
	//Setup View Count
	int ViewCount;
	
	
}

//Array's
@property (nonatomic, retain) NSMutableArray *Score;
@property (nonatomic, retain) NSMutableArray *Names;
@property (nonatomic, retain) NSMutableArray *Dates;
@property (nonatomic, retain) NSMutableArray *ProfilePictures;

@property (nonatomic) int launchCount;
@property (nonatomic) int ViewCount;

@property (nonatomic, retain) IBOutlet FacebookAPIViewController *viewController;

@property (nonatomic, retain) Play *pl;

@property (nonatomic, retain) IBOutlet NSString *name;


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LoadupView *viewController2;

- (void) authenticateLocalPlayer;
- (void) registerForAuthenticationNotification;
- (void) authenticationChanged;

@end

