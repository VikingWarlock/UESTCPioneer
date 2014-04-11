//
//  LongCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/24/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellWithCustomLeftImageAndLabel.h"

@implementation CellWithCustomLeftImageAndLabel

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.label];
        [self addSubview:self.leftImage];
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

- (UIImageView *)leftImage
{
    if(!_leftImage)
    {
        _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        _leftImage.center = CGPointMake(20, self.center.y);
    }
    return _leftImage;
}

- (UILabel *)label
{
    if(!_label)
        _label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 270, self.frame.size.height)];
    return _label;
}
@end
