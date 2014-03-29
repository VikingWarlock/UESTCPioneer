//
//  ShortHeadCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/27/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "ShortHeadCell.h"

@implementation ShortHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.image];
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

- (UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.origin.y, 70, self.frame.size.height)];
    }
    return _label;
}

- (UIImageView *)image
{
    if (!_image)
    {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(100,4,55,55)];
    }
    return _image;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = 64;
    frame.origin.x += 10;
    frame.size.width -= 2 * 10;
    [super setFrame:frame];
}

@end
