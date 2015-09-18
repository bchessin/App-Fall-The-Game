//
//  TCell.m
//  AppFall3
//
//  Created by Brad Chessin on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TCell.h"


@implementation TCell

@synthesize scoreLabel = ivscoreLabel;
@synthesize nameLabel = ivnameLabel;
@synthesize dateLabel = ivdateLabel;
@synthesize profilePicture = ivprofilePicture;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[ivdateLabel release], ivdateLabel = nil;
    [ivnameLabel release], ivnameLabel = nil;
	[ivscoreLabel release], ivscoreLabel = nil;
    [ivprofilePicture release], ivprofilePicture = nil;
    [super dealloc];
}


@end
