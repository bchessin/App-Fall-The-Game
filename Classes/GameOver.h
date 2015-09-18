//
//  GameOver.h
//  AppFall3
//
//  Created by Brad Chessin on 12/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Play.h"
#import <GameKit/GameKit.h>
//#import "FBConnect.h"

@class Play;
@class SA_OAuthTwitterEngine;

@interface GameOver : UIViewController <MFMailComposeViewControllerDelegate, UIActionSheetDelegate, GameCenterManagerDelegate, GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate> {
	
	IBOutlet UIButton *button1;
	IBOutlet UIButton *button2;
	
	UIImage *currentImage;
	
	UIImage *screenShotImage;
	
	UIImage *screenShotImage2;
	
	//Facebook
	UIAlertView *facebookAlert;
	NSString *username;
	BOOL post;

	int score;
	
	//ImageViews for sharing picture
	UIImageView *sharingpicture1;
	UIImageView *sharingpicture2;
	
	//NSDictionary
	NSDictionary *dict;
	
}

//Facebook
- (IBAction)shareOnFacebook;
- (void)fbDidLogin;
@property(nonatomic,retain)	UIAlertView *facebookAlert;
@property(nonatomic,retain) NSString *username;
@property(nonatomic,assign) BOOL post;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@property(nonatomic, readonly, retain) UIImage *currentImage;



- (IBAction)playagain;
- (IBAction)mainmenu;

//Sharing Actions
- (IBAction)mailBtn;
- (IBAction)sendtweet;

- (IBAction)sendimage1;
- (IBAction)sendimage2;

- (IBAction)GameCenterActionSheet;

//Make a new cell in stats
- (void)submitScore;


@end
