//
//  UPMainInfoCell.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPMainInfoCell.h"

@implementation UPMainInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect wordsRect = CGRectMake(5, 3, 290, 80);
        UILabel *wordsLabel = [[UILabel alloc]initWithFrame:wordsRect];
        wordsLabel.font = [UIFont systemFontOfSize:wordsFontSize];
        wordsLabel.tag = wordsTag;
        wordsLabel.textColor = [UIColor blackColor];
        wordsLabel.lineBreakMode = NSLineBreakByWordWrapping;
        wordsLabel.numberOfLines = 0;
        [wordsLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:wordsLabel];
        
        CGRect btnRect = CGRectMake(5, 85, 40, 20);
        UILabel *btnLabel = [[UILabel alloc]initWithFrame:btnRect];
        btnLabel.font = [UIFont systemFontOfSize:16];
        btnLabel.tag = 1;
        btnLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0.4 alpha:1];
        btnLabel.text = @"全文";
        [btnLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:btnLabel];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
