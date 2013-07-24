//
//  DinaveckarCell.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/24/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "DinaveckarCell.h"

@implementation DinaveckarCell
@synthesize cellBtn;
@synthesize cellLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
