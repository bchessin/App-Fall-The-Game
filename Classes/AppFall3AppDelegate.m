//
//  AppFall3AppDelegate.m
//  AppFall3
//
//  Created by Brad Chessin on 10/2/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AppFall3AppDelegate.h"
#import "AppFall3ViewController.h"
#import "Play.h"
#import "LoadupView.h"
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"
#import "AppSpecificValues.h"
#import "Appirater.h"

@implementation AppFall3AppDelegate


@synthesize window;
@synthesize viewController2;
@synthesize name;
@synthesize pl;
@synthesize viewController;
@synthesize ViewCount;

@synthesize launchCount;

//Arrays's
@synthesize Score;
@synthesize Names;
@synthesize Dates;
@synthesize ProfilePictures;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
	
	//Flurry
	//[FlurryAPI startSession:@"TR1ZT7RUY3JVDY7NXLBR"];
	
	//NSUserDefault ints
	ViewCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"SetupViewCount"];
	launchCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"Launches"];
	
	//Anti-Piracy Code
	NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
	NSString* path = [NSString stringWithFormat:@"%@/Info.plist", bundlePath];
	NSString* path2 = [NSString stringWithFormat:@"%@/AppName", bundlePath];
	NSDate* infoModifiedDate = [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileModificationDate];
	NSDate* infoModifiedDate2 = [[[NSFileManager defaultManager] attributesOfItemAtPath:path2 error:nil] fileModificationDate];
	NSDate* pkgInfoModifiedDate = [[[NSFileManager defaultManager] attributesOfItemAtPath:[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"PkgInfo"] error:nil] fileModificationDate]; 
		
	if([infoModifiedDate timeIntervalSinceReferenceDate] > [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) {	
		//Pirated
		UIAlertView *crackalert =[[UIAlertView alloc] initWithTitle:@"Trial Mode" message:@"This app is cracked and is running in trial mode. You only can open the app one time then you have to buy it." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[crackalert show];
		[crackalert release];
		
		if (launchCount >= 2) {
			
			//Action on second launch
			exit(0);
			
		}
		
		//Put launchCount int stuff in here and the next if
		
	}
	if([infoModifiedDate2 timeIntervalSinceReferenceDate] > [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) {	
		//Pirated
		UIAlertView *crackalert =[[UIAlertView alloc] initWithTitle:@"Trial Mode" message:@"This app is cracked and is running in trial mode. You only can open the app one time then you have to buy it." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[crackalert show];
		[crackalert release];
		
		if (launchCount >= 2) {
			
			//Action on second launch
			exit(0);
			
		}
	}
	
	//Game Center methods
	 
	[self authenticateLocalPlayer];
	[self registerForAuthenticationNotification];
	[self authenticationChanged];
	
	
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    [window addSubview:viewController2.view];
    [window makeKeyAndVisible];

    return YES;
}


//Methods for Game Center

- (void) authenticateLocalPlayer
{
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
		if (error == nil)
		{
			// Insert code here to handle a successful authentication.
		}
		else
		{
			// Your application can process the error parameter to report the error to the player.
		}
	}];
}

- (void) registerForAuthenticationNotification
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver: self
           selector:@selector(authenticationChanged)
               name:GKPlayerAuthenticationDidChangeNotificationName
             object:nil];
}

- (void) authenticationChanged
{
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        // Insert code here to handle a successful authentication.
	}
	else {
			// Insert code here to clean up any outstanding Game Center-related classes.
			}
}
 

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	
	[[NSUserDefaults standardUserDefaults] setInteger:ViewCount forKey:@"SetupViewCount"];
	
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	[Appirater applicationWillEnterForeground];
	
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	
	[[NSUserDefaults standardUserDefaults] setInteger:launchCount forKey:@"Launches"];
	
	launchCount++;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"UPAlert" object:self]; 
	
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

//Method to see if device supports multitasking

- (BOOL) isMultitaskingCapable
{
	UIDevice* device = [UIDevice currentDevice];
	BOOL backgroundSupported = NO;
	if ([device respondsToSelector:@selector(isMultitaskingSupported)])
		backgroundSupported = device.multitaskingSupported;
	
	return backgroundSupported;
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
	
	
}


- (void)dealloc {
    [viewController2 release];
    [window release];
	[pl release];
	[viewController release];
    [super dealloc];
}


@end
