//
//  UPCell.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-31.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPCell.h"

@implementation UPCell

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

-(void)setFrame:(CGRect)frame{
    frame.size.width-=20;
    frame.origin.x+=10;
    [super setFrame:frame];
}

@end
