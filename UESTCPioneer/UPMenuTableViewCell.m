//
//  UPMenuTableViewCell.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPMenuTableViewCell.h"

@implementation UPMenuTableViewCell

UIColor *backGroundColor;
UIColor *textColor;
UIColor *selectedCellColor;
UIColor *newsCountLabelColor;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        backGroundColor = [UIColor colorWithRed:37.0/255.0 green:41.0/255.0 blue:50.0/255 alpha:1];
        textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
        selectedCellColor = [UIColor colorWithRed:28.0/255.0 green:33.0/255.0 blue:39.0/255.0 alpha:1];
        newsCountLabelColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = selectedCellColor;
        [self setBackgroundColor:backGroundColor];
        [self.contentView addSubview:self.leftImageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(UIImageView *)leftImageView
{
    if(!_leftImageView)
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16,10, 30, 30)];
    return _leftImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 320, 53)];
    _titleLabel.textColor = textColor;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.backgroundColor = [UIColor clearColor];
    return _titleLabel;
}

-(UILabel *)newsCountLabel
{
    if(!_newsCountLabel)
        _newsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 17, 35, 20)];
    _newsCountLabel.layer.cornerRadius = 10;
    _newsCountLabel.textColor = [UIColor whiteColor];
    _newsCountLabel.font = [UIFont systemFontOfSize:13];
    _newsCountLabel.textAlignment = NSTextAlignmentCenter;
    _newsCountLabel.backgroundColor = newsCountLabelColor;
    return _newsCountLabel;
}

-(void)showNewsCountLabel:(NSInteger)counts
{
    if (counts <= 0) {
        [self.newsCountLabel removeFromSuperview];
    }
    else if (counts <99)
    {
        self.newsCountLabel.text = [NSString stringWithFormat:@"%ld",(long)counts];
        [self.contentView addSubview:self.newsCountLabel];
    }
    else
    {
        self.newsCountLabel.text = @"99+";
        [self.contentView addSubview:self.newsCountLabel];
    }
}


@end
