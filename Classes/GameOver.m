//
//  GameOver.m
//  AppFall3
//
//  Created by Brad Chessin on 12/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameOver.h"
#import "Play.h"
#import "Appirater.h"
#import "Singleton.h"
#import <Twitter/TWTweetComposeViewController.h>

//Facebook Keys
#define _APP_KEY @"2bff86808220ba2dc7767c74d48a13cc"
#define _SECRET_KEY @"4c7a2d01a18fee826d4b3d38c6749b1f"

#define kApiKey @"2bff86808220ba2dc7767c74d48a13cc"

#define kFacebookPermissions @"read_stream", @"offline_access", @"publish_stream"

@implementation GameOver

@synthesize currentImage;

@synthesize facebookAlert;
@synthesize username;
@synthesize post;

- (void)submitScore {
	
	//Delete the previous dictionary
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cellDictionary"];
	
	AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	//Which person is playing
	NSInteger myInt = [prefs integerForKey:@"PlayingPerson"];
	//Name
	NSString *name = [appDelegate.Names objectAtIndex:myInt];
	//Score
	int thescore = [[NSUserDefaults standardUserDefaults] integerForKey:@"GameCenterScore"];
	//Date
	NSDate *myDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"theDate"];
	//Profile Picture
	UIImage *profileImage = [appDelegate.ProfilePictures objectAtIndex:myInt];
	
	//Create a NSDictionary to save and then create a new cell
	dict = [NSDictionary dictionaryWithObjectsAndKeys:
			name, @"Name", 
			thescore, @"Score", 
			myDate, @"Date", 
			profileImage, @"ProfileImage", nil];
	
	//Save the dictionary
	[[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"cellDictionary"];
	
	//First Person
	if (myInt == 0) {
		[appDelegate.Score addObject:[NSNumber numberWithInt:thescore]];
		
	}
	//Second Person
	if (myInt == 1) {
		[appDelegate.Score addObject:[NSNumber numberWithInt:thescore]];
		
	}
	//Third Person
	if (myInt == 2) {
		[appDelegate.Score addObject:[NSNumber numberWithInt:thescore]];
		
	}
	//Fourth Person
	if (myInt == 3) {
		[appDelegate.Score addObject:[NSNumber numberWithInt:thescore]];
		
	}
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:TRUE forKey:@"NewCell"];
	[defaults synchronize];
	
}

- (IBAction)playagain {
	
	//Use same animation from Main View Controller to Play
	Play *pl = [[Play alloc] initWithNibName: @"Play" bundle:nil];
	[self presentModalViewController: pl animated: YES];
	[pl release];
	
}

- (IBAction)mainmenu {
	
	AppFall3ViewController *vc = [[AppFall3ViewController alloc] initWithNibName: @"AppFall3ViewController" bundle:nil];
	vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController: vc animated: YES];
	[vc release];
	
}
 
- (IBAction)mailBtn
{
	score = [[NSUserDefaults standardUserDefaults] integerForKey:@"GameCenterScore"];
	
	MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
	composer.mailComposeDelegate = self;
	
	if ([MFMailComposeViewController canSendMail]) {
		[composer setToRecipients:[NSArray arrayWithObjects:nil]];
		[composer setSubject:@"How far can you get in App Fall?"];
		[composer setMessageBody:@"I got up to %i in App Fall!!!! Try to beat that!!! App Fall is ao ADDICTING! I am hooked. This game is unstoppable. Period. Get it on the iTunes App Store and let's see who can get higher!" isHTML:NO];
		[self presentModalViewController:composer animated:YES];
	}
	
	[composer release];
	
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissModalViewControllerAnimated:YES];
	
	if (result == MFMailComposeResultFailed) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed!" message:@"The email failed to send" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (IBAction)sendimage1 {
	
	UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"Where do you want to share this image?"  delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email", @"Twitter", @"Facebook", nil];
	[actionsheet showInView:self.view];
	[actionsheet release];
	actionsheet.tag = 2;
	
}

- (IBAction)sendimage2 {
	
	UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"Where do you want to share this image?"  delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email", @"Twitter", @"Facebook", nil];
	[actionsheet showInView:self.view];
	[actionsheet release];
	actionsheet.tag = 3;
	
}

- (void)uploadPhoto:(UIImage *)uploadImage
{
    /*
	NSLog(@"uploadImage %@", uploadImage);
    NSMutableDictionary *args = [[[NSMutableDictionary alloc] init] autorelease];
	FBRequest *uploadPhotoRequest = [FBRequest requestWithDelegate:self]; 
    [args setObject:uploadImage forKey:@"image"]; 
    [args setObject:@"4865751097970555873" forKey:@"aid"];// this should be album id
    [uploadPhotoRequest call:@"photos.upload" params:args];
	FBRequest *req = [FBRequest getRequestWithParams:args httpMethod:@"photos.upload" delegate:self requestURL:@"i dont know about this one"];
     */
	
    NSLog(@"uploading image is successful");
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		
		if(actionSheet.tag == 1) {
			
			[self performSelector:@selector(showLeaderboard) withObject:nil afterDelay:0.0];
			
		}
		
		if(actionSheet.tag == 2) {
			//First alert - handle button click action here...
			MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
			composer.mailComposeDelegate = self;
			
			if ([MFMailComposeViewController canSendMail]) {
				[composer setToRecipients:[NSArray arrayWithObjects:nil]];
				[composer setSubject:@"How far can you get in App Fall?"];
				NSString *mbody = [NSString stringWithFormat:@"I got up to %i in App Fall!!!! Try to beat that!!! App Fall is so ADDICTING! I am hooked. This game is unstoppable. Period. Get it on the iTunes App Store and let's see who can get higher!",score];
				[composer setMessageBody:mbody isHTML:NO];
				
				UIImage *mailpic1 = [button1 imageForState:UIControlStateNormal];
				NSData *exportData = UIImagePNGRepresentation(mailpic1);
				[composer addAttachmentData:exportData mimeType:@"image/png" fileName:@"Screenshot.png"];
				[self presentModalViewController:composer animated:YES];
				
			}
			
			[composer release];
			
		}
		if(actionSheet.tag == 3) {
			//Second alert - handle button click action here...
			MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
			composer.mailComposeDelegate = self;
			
			if ([MFMailComposeViewController canSendMail]) {
				[composer setToRecipients:[NSArray arrayWithObjects:nil]];
				[composer setSubject:@"How far can you get in App Fall?"];
				NSString *mbody = [NSString stringWithFormat:@"I got up to %i in App Fall!!!! Try to beat that!!! App Fall is so ADDICTING! I am hooked. This game is unstoppable. Period. Get it on the iTunes App Store and let's see who can get higher!",score];
				[composer setMessageBody:mbody isHTML:NO];
				
				UIImage *mailpic2 = [button2 imageForState:UIControlStateNormal];
				NSData *exportData2 = UIImagePNGRepresentation(mailpic2);
				[composer addAttachmentData:exportData2 mimeType:@"image/png" fileName:@"Screenshot2.png"];
				[self presentModalViewController:composer animated:YES];
				
			}
			
			[composer release];
			
		}
		
	}
	
	if (buttonIndex == 1) {
		
		if(actionSheet.tag == 1) {
			
			[self performSelector:@selector(showAchievements) withObject:nil afterDelay:0.0];
			
		}
		
		if(actionSheet.tag == 2) {
			//Twitter
            TWTweetComposeViewController *tweetComposer = [[TWTweetComposeViewController alloc] init];
            
            NSString *text = @"App Fall is the best game ever. This is a picture from my game. Check it out!!!";
            [tweetComposer setInitialText:text];
            
            NSData *ss1 = (NSData *) [[NSUserDefaults standardUserDefaults] objectForKey:@"GameImage1"];
            if (ss1 != nil) {
            //[tweetComposer addImage:button1.image];
            }
            
            [self presentViewController:tweetComposer animated:YES completion:NULL]; // recommended on iOS 5
            
            
            tweetComposer.completionHandler = ^(TWTweetComposeViewControllerResult result) {
                
                [self dismissViewControllerAnimated:YES completion:NULL]; // recommended on iOS 5
                
            };

		}
		
		if(actionSheet.tag == 3) {
			//Second alert - handle button click action here...
            //Twitter 
            TWTweetComposeViewController *tweetComposer = [[TWTweetComposeViewController alloc] init];
            
            NSString *text = @"App Fall is the best game ever. This is a picture from my game. Check it out!!!";
            [tweetComposer setInitialText:text];
            
            NSData *ss2 = (NSData *) [[NSUserDefaults standardUserDefaults] objectForKey:@"GameImage2"];
            if (ss2 != nil) {
            // [tweetComposer addImage:button2.image];
            }
            
            [self presentViewController:tweetComposer animated:YES completion:NULL]; // recommended on iOS 5
            
            
            tweetComposer.completionHandler = ^(TWTweetComposeViewControllerResult result) {
                
                [self dismissViewControllerAnimated:YES completion:NULL]; // recommended on iOS 5
                
            };

            
		}
		
	}
	
	if (buttonIndex == 2) {
		
		if(actionSheet.tag == 2) {
			
			UIImage *photo1 = [button1 imageForState:UIControlStateNormal];
			NSLog(@"photo1 %@", photo1);
			[self uploadPhoto:photo1];
			
		}
		if(actionSheet.tag == 3) {
			
			UIImage *photo2 = [button2 imageForState:UIControlStateNormal];
			NSLog(@"photo2 %@", photo2);
			[self uploadPhoto:photo2];
			
		}
		
	}
	
}

- (IBAction)sendtweet {
	
    TWTweetComposeViewController *tweetComposer = [[TWTweetComposeViewController alloc] init];
    
    NSString *text = @"App Fall is the best game ever. Check it out here: Link";
    [tweetComposer setInitialText:text];
    
    [self presentViewController:tweetComposer animated:YES completion:NULL]; // recommended on iOS 5
    
    
    tweetComposer.completionHandler = ^(TWTweetComposeViewControllerResult result) {
        
        [self dismissViewControllerAnimated:YES completion:NULL]; // recommended on iOS 5
        
    };
	
}

- (IBAction)shareOnFacebook {
    /*
	Facebook *fb = [Singleton sharedFacebookHandle];
	
	if ([fb isSessionValid]) {
		SBJSON *jsonWriter = [[SBJSON new] autorelease];
		
		NSString *strSubject = @"This is my first facebook post!";
		NSString *strContent = @"here's my description";
		NSString *strImageUrl = @"http://www.mysite.com/images/funnypic.jpg";
		NSString *strSomeUrlForTheClickableImage = @"http://www.mysite.com";
		NSString *strSomeUrlForTheClickablePostTitle = @"http://www.mysite.com";
		
		// do your things here...
		NSDictionary *media1 = [NSDictionary dictionaryWithObjectsAndKeys:
								@"image", @"type",
								strImageUrl, @"src",
								strSomeUrlForTheClickableImage, @"href"
								,nil];
		
		NSArray *media = [NSArray arrayWithObjects:media1, nil];
		
		NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
							 strSubject, @"name",
							 strContent, @"description",
							 strSomeUrlForTheClickablePostTitle, @"href",
							 media, @"media",
							 nil];
		
		NSString *attachment = [jsonWriter stringWithObject:dic];
		
		NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys: 
									   kApiKey, @"api_key",
									   attachment, @"attachment",
									   nil];
		
		[fb dialog:@"stream.publish" andParams:params andDelegate:self];
	} else {
		NSArray *permissions = [NSArray arrayWithObjects:kFacebookPermissions,nil];
		//[fb authorize:_APP_KEY permissions:permissions delegate:self];
		[fb authorize:permissions delegate:self];
	}
     */
}

// Gets called after the [fb authorized] got a successful facebook login of the user;
- (void)fbDidLogin {
	[self shareOnFacebook];
}

/*
- (IBAction)sendfacebook {
	
	AppFall3AppDelegate *appDelegate =
	(AppFall3AppDelegate *)   [[UIApplication
								sharedApplication]delegate];
	if (appDelegate._session == nil){
		appDelegate._session = [FBSession
								sessionForApplication:_APP_KEY
								secret:_SECRET_KEY delegate:self];
	}
	
	self.loginButton = [[[FBLoginButton alloc] init] autorelease];
	
	//We resume the session if there is one already
	[appDelegate._session resume];
	
	
}


- (void)session:(FBSession*)session didLogin:(FBUID)uid {
	self.usersession =session;
	NSLog(@"User with id %lld logged in.", uid);
	[self getFacebookName];
}

- (void)request:(FBRequest*)request didLoad:(id)result {
	if ([request.method isEqualToString:@"facebook.fql.query"]) {
		NSArray* users = result;
		NSDictionary* user = [users objectAtIndex:0];
		NSString* name = [user objectForKey:@"name"];
		self.username = name;
		
		if (self.post) {
			[self postToWall];
			self.post = NO;
		}
	}
}


- (void)postToWall {
	
	FBStreamDialog *dialog = [[[FBStreamDialog alloc] init]
							  autorelease];
	dialog.userMessagePrompt = @"Enter your message:";
	//Name: Replace Test with Title of Post
	//Href: Link
	//Description: description
	//Media: Link to the icon of app
	
	dialog.attachment = [NSString stringWithFormat:@"{\"Test\":\"Check Out App Fall for iPhone!\",\"href\":\"www.iBradApps.com\",\"description\":\"I found this great new app called App Fall by iBrad Applications! \",\"href\":\"www.iBradApps.com\",\"media\":[{\"type\":\"image\",\"src\":\"directlinktotheimagegoeshere.png\",\"href\":\"the same directlinktothatimagegoeshere.png\"}]}"];
	
	[dialog show];
	
}
 */


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)uploadscore {
	
	//This is the same category id you set in your itunes connect GameCenter LeaderBoard
    GKScore *myScoreValue = [[[GKScore alloc] initWithCategory:@"1"] autorelease];
    myScoreValue.value = score;
	
    [myScoreValue reportScoreWithCompletionHandler:^(NSError *error){
        if(error != nil){
            NSLog(@"Score Submission Failed");
        } else {
            NSLog(@"Score Submitted");
        }
		
    }];
	
}

- (void) showLeaderboard
{
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil)
    {
        leaderboardController.leaderboardDelegate = self;
        [self presentModalViewController: leaderboardController animated: YES];
    }
}

- (void) showAchievements
{
    GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
    if (achievements != nil)
    {
        achievements.achievementDelegate = self;
        [self presentModalViewController: achievements animated: YES];
    }
    [achievements release];
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)GameCenterActionSheet {
	
	UIActionSheet *gamecenterAS = [[UIActionSheet alloc] initWithTitle:@"What do you want to view?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Leaderboards", @"Achievements", nil];
	gamecenterAS.tag = 1;
	[gamecenterAS showInView:self.view];
	[gamecenterAS release];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self submitScore];
    
    //Rating Code
	[Appirater appLaunchedWithID:1245678];
	
	score = [[NSUserDefaults standardUserDefaults] integerForKey:@"GameCenterScore"];
	[self uploadscore];
	
	//Button 1 Stuff
	NSData *ss1 = (NSData *) [[NSUserDefaults standardUserDefaults] objectForKey:@"GameImage1"];
	if (ss1 != nil) {
		[button1 setImage:[UIImage imageWithData:ss1] forState:UIControlStateNormal];
	}
	else if (ss1 == nil){
		[button1 setImage:[UIImage imageNamed:@"Graph-Paper.png"] forState:UIControlStateNormal];
		button1.enabled = NO;
	}
	//End
	
	//Button 2 Stuff
	NSData *ss2 = (NSData *) [[NSUserDefaults standardUserDefaults] objectForKey:@"GameImage2"];
	if (ss2 != nil) {
		[button2 setImage:[UIImage imageWithData:ss2] forState:UIControlStateNormal];
	}
	else if (ss2 == nil){
		[button2 setImage:[UIImage imageNamed:@"Graph-Paper.png"] forState:UIControlStateNormal];
		button2.enabled = NO;
	}
	//End
	
}

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

- (void)viewWillDisappear:(BOOL)animated {
	NSLog(@"ViewWillDisappear");
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"GameImage1"];
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"GameImage2"];
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"GameCenterScore"];
	
}

- (void)dealloc {
    [super dealloc];
	[currentImage release];
	[screenShotImage release];
	[screenShotImage2 release];
	[username release];
	
}


@end
