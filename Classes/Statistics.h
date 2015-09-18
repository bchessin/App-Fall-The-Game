//
//  Statistics.h
//  AppFall3
//
//  Created by Brad Chessin on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@class TCell;

@interface Statistics : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate> {

	NSMutableArray *contentArray;
	
	BOOL isGameCenterAvailable;
	
	UITableView *ivstatstableView;
	TCell *ivCustomTableCell;
	
	IBOutlet UISegmentedControl *sortbar;
	
	NSArray *sortedScoreArray;
	
}

@property (nonatomic, retain) IBOutlet UITableView *statstableView;
@property (nonatomic, retain) IBOutlet TCell *CustomTableCell;

- (IBAction)sortbartouchdown;

- (IBAction)back;

- (IBAction)gamecntr;

- (NSString *)documentsDirectory;
- (UIImage*)loadImage:(NSString*)imageName; // lets you load an image saved to the documents directory

//- (void)getObjectFromDocumentsDirectory;

- (void)showLeaderboard;
- (void)showAchievements;
- (void)reloadinfoCells;

@end
