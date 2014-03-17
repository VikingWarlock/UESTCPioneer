//
//  UPTitleCell.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPTitleCell.h"

@implementation UPTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect titleRect = CGRectMake(10, 10, 250, 20);
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:titleRect];
        titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
        titleLabel.tag = titleTag;
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:titleLabel];
        
        CGRect timeRect = CGRectMake(10, 30, 250, 20);
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:timeRect];
        timeLabel.font = [UIFont systemFontOfSize:timeFontSize];
        timeLabel.tag = timeTag;
        timeLabel.textColor = [UIColor grayColor];
        [timeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:timeLabel];
        
        CGRect collectRect = CGRectMake(230, 20, 60, 20);
        UIButton *collect = [[UIButton alloc]initWithFrame:collectRect];
        collect.tag = collectTag;
        collect.hidden = YES;
        [collect setImage:[UIImage imageNamed:@"collect.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:collect];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
