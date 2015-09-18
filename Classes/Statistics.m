//
//  Statistics.m
//  AppFall3
//
//  Created by Brad Chessin on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Statistics.h"
#import <QuartzCore/QuartzCore.h>
#import "AppFall3ViewController.h"
#import "TCell.h"

@implementation Statistics

@synthesize statstableView = ivstatstableView;
@synthesize CustomTableCell = ivCustomTableCell;

- (IBAction)sortbartouchdown {
	
	AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//Date
	if(sortbar.selectedSegmentIndex == 0){
		
		//Get Date and sort from newest
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"beginDate" ascending:TRUE];
		[appDelegate.Dates sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
		[sortDescriptor release];
		
		//Now reorder tableview using the code above and animated
		TCell *tc = [[TCell alloc] init];
		[UIView setAnimationDelegate:self];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.25];
		[tc.scoreLabel setAlpha:0];
		[tc.nameLabel setAlpha:0];
		[tc.nameLabel setAlpha:0];
		[tc.profilePicture setAlpha:0];
		[UIView commitAnimations];
		[tc release];
		[UIView setAnimationDidStopSelector:@selector(reloadinfoCells)];
		
	}
	
	//Score
	if(sortbar.selectedSegmentIndex == 1){
		
		sortedScoreArray = [appDelegate.Score sortedArrayUsingSelector:@selector(intValue)];
		//Move cells to appropriate places and animated
		[sortedScoreArray lastObject];
		
		TCell *tc = [[TCell alloc] init];
		[UIView setAnimationDelegate:self];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.25];
		[tc.scoreLabel setAlpha:0];
		[tc.nameLabel setAlpha:0];
		[tc.nameLabel setAlpha:0];
		[tc.profilePicture setAlpha:0];
		[UIView commitAnimations];
		[tc release];
		[UIView setAnimationDidStopSelector:@selector(reloadinfoCells)];
	}
	
	
}

- (void)reloadinfoCells {
	
	//Make all the info go into the right spots here
	
	TCell *tc = [[TCell alloc] init];
	[UIView setAnimationDelegate:self];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25];
	[tc.scoreLabel setAlpha:1];
	[tc.nameLabel setAlpha:1];
	[tc.nameLabel setAlpha:1];
	[tc.profilePicture setAlpha:1];
	[UIView commitAnimations];
	[tc release];
	
}

- (IBAction)back {
	
	[[NSUserDefaults standardUserDefaults] setObject:contentArray forKey:@"ContentArray"];

	AppFall3ViewController *vc = [[AppFall3ViewController alloc] initWithNibName: @"AppFall3ViewController" bundle:nil];
	vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController: vc animated: YES];
	[vc release];
	
}

- (NSString *)documentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
	NSLog(@"Documents Directory: %@", [paths objectAtIndex:0]);
}

- (UIImage*)loadImage:(NSString*)imageName {
	
	NSString *fullPath = [[self documentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"MyFace.png"]];
	
	return [UIImage imageWithContentsOfFile:fullPath];
	
	NSLog(@"%@", fullPath);
	
}

- (IBAction)gamecntr {

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What do you want to view?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Leaderboards", @"Achievements", nil];
	actionSheet.tag = 1;
	[actionSheet showInView:self.view];
	[actionSheet release];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		
		if(actionSheet.tag == 1) {
			
			[self performSelector:@selector(showLeaderboard) withObject:nil afterDelay:0.0];
			
		}
		
		if(actionSheet.tag == 2) {
			//First alert - handle button click action here...

			
		}
		
	}
	
	if (buttonIndex == 1) {
		
		if(actionSheet.tag == 1) {
			
			[self performSelector:@selector(showAchievements) withObject:nil afterDelay:0.0];
			
		}
		
		if(actionSheet.tag == 2) {
			
		}
		
	}
	
	if (buttonIndex == 2) {
		
		if(actionSheet.tag == 2) {
			
			
		}
		
	}
	
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

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
	
	NSInteger sections = 1;
	
	NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
	return sections;
}



// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//If Score is 0 then the UITableView will not respond (unfunctional), also can use appDelegate.Dates
	//AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	//return 2;
	
	//Get the contentArray from NSUserDefaults
	NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
	contentArray = [currentDefaults objectForKey:@"ContentArray"];
	
	//Add a NSDictionary to the contentArray if needed
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	Boolean shouldPlayMusic = [defaults boolForKey:@"NewCell"];
	if (shouldPlayMusic == TRUE) {
		//Get the NSDictionary
		NSDictionary *myDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"cellDictionary"];
		[contentArray addObject:myDictionary];
	}
		return [contentArray count];
		//return 0; //Failsafe
	}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 60;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSLog(@"cellForRowAtIndexPath");
		
	static NSString *CellIdentifier = @"CellIdentifier";
	
	TCell *cell = (TCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		[[NSBundle mainBundle] loadNibNamed:@"TCell" owner:self options:nil];
		cell = [self CustomTableCell];
		[self setCustomTableCell:nil];
	}
		
	//NSUserDefaultLine
	NSDictionary *myDictionary = [contentArray objectAtIndex:indexPath.row];
	//Name
	cell.nameLabel.text = [myDictionary objectForKey:@"Name"];
	//Score
	cell.scoreLabel.text = [NSString stringWithFormat:@"%d", [[myDictionary objectForKey:@"Score"] integerValue]];
	//Date
	cell.dateLabel.text = [myDictionary objectForKey:@"Date"];
	//Profile Picture
	cell.profilePicture.image = [myDictionary objectForKey:@"ProfileImage"];
	
		/*
	//Put the score, date, name, and profilePicture into the appropriate cell row
	AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	cell.scoreLabel = [appDelegate.Score objectAtIndex:indexPath.row];
	cell.dateLabel = [appDelegate.Dates objectAtIndex:indexPath.row];
	cell.nameLabel = [appDelegate.Names objectAtIndex:indexPath.row];
	cell.profilePicture.image = [appDelegate.ProfilePictures objectAtIndex:indexPath.row];
		 */
	
	return cell;
	
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
	
	NSUInteger scorerow = [indexPath row];
	AppFall3AppDelegate *appDelegate = (AppFall3AppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate.Score objectAtIndex:scorerow];
	
	//ActionSheet for sharing stuff here
	UIActionSheet *shareScore = [[UIActionSheet alloc] initWithTitle:@"Where do you want to share the score?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"FaceBook", @"Twitter", @"E-Mail", nil];
	shareScore.tag = 2;
	[shareScore showInView:self.view];
	[shareScore release];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		[contentArray removeObjectAtIndex:indexPath.row];
		[ivstatstableView reloadData];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
	
	ivstatstableView.delegate = self;
	ivstatstableView.dataSource = self;
	
	[ivstatstableView reloadData];
	
	Class gameKitLocalPlayerClass = NSClassFromString(@"GKLocalPlayer");
	bool isLocalPlayerAvailable = (gameKitLocalPlayerClass != nil);
	
	// Test if device is running iOS 4.1 or higher
	NSString* reqSysVer = @"4.1";
	NSString* currSysVer = [[UIDevice currentDevice] systemVersion];
	bool isOSVer41 = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
	
	isGameCenterAvailable = (isLocalPlayerAvailable && isOSVer41);
	NSLog(@"GameCenter available = %@", isGameCenterAvailable ? @"YES" : @"NO");
	
	if (!isGameCenterAvailable) {
		
		self.navigationItem.leftBarButtonItem=nil;
		
	}
	
	/*
	pictures = [[NSMutableArray alloc] init];
	[pictures addObject:@"MyFace.png"];
	NSString *mainpath = [[NSBundle mainBundle] bundlePath];
    Facepicture.image = [UIImage imageWithContentsOfFile:[mainpath stringByAppendingString:@"MyFace.png"]];
    Facepicture.layer.cornerRadius = 15.0;
	 */
	
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
	[ivstatstableView release], ivstatstableView = nil;
    [ivCustomTableCell release], ivCustomTableCell = nil;
    [super dealloc];
	}


@end
