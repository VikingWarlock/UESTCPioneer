//
//  ShortTitleCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/22/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellForDailyCare_TitleCell.h"

@implementation CellForDailyCare_TitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.head];
        // Initialization code
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.size.width -= 2 * 10;
    [super setFrame:frame];
}

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 250, 20)];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textColor = [UIColor blackColor];
        [_title setTextAlignment:NSTextAlignmentLeft];
        _title.text = @"title";
    }
    return _title;
}

- (UILabel *)time
{
    if (!_time) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 250, 20)];
        _time.font = [UIFont systemFontOfSize:12];
        _time.textColor = [UIColor grayColor];
        [_time setTextAlignment:NSTextAlignmentLeft];
        _time.text = @"time";
    }
    return _time;
}

- (UIImageView *)head
{
    if (!_head) {
        _head = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
        _head.image = [UIImage imageNamed:@"default_head_image.png"];
    }
    return _head;
}


@end
