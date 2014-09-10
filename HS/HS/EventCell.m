//
//  EventCell.m
//  HS
//
//  Created by Irene Lee on 8/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell
@synthesize titleLabel, contentLabel, dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
