//
//  CellForDailyCare_BodyCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/22/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellForDailyCare_BodyCell.h"

@implementation CellForDailyCare_BodyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.size.width -= 2 * 10;
    [super setFrame:frame];
}
@end
