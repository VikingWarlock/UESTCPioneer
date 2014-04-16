//
//  ShortCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellForPersonalInformation.h"

@implementation CellForPersonalInformation

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.staticLabel];
        [self.contentView addSubview:self.leftImage];
    }
    return self;
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.size.width -= 2 * 10;
    [super setFrame:frame];
}

- (UIImageView *)leftImage
{
    if (!_leftImage)
    {
        _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.origin.x ,4,55,55)];
    }
    return _leftImage;
}

- (UILabel *)staticLabel
{
    if (!_staticLabel)
    {
        _staticLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.origin.y, 70, self.frame.size.height)];
        _staticLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
    }
    return _staticLabel;
}

@end
