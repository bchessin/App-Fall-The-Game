//
//  TCell.h
//  AppFall3
//
//  Created by Brad Chessin on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TCell : UITableViewCell {
	
	UILabel *ivscoreLabel;
	UILabel *ivdateLabel;
	UILabel *ivnameLabel;
	UIImageView *ivprofilePicture;

}

@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *profilePicture;

@end
