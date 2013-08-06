//
//  UtvarderingCell.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 07/08/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "UtvarderingCell.h"

@implementation UtvarderingCell
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
