//
//  CellForStartActivity.m
//  UESTCPioneer
//
//  Created by 张众 on 4/2/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellForStartActivity.h"

@implementation CellForStartActivity

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addpic.png"]]];
        [self.contentView addSubview:self.thumbnail];
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

- (UIImageView *)thumbnail
{
    if (!_thumbnail) {
        _thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _thumbnail.image = nil;
        _thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnail.clipsToBounds = YES;
    }
    return _thumbnail;
}

@end
