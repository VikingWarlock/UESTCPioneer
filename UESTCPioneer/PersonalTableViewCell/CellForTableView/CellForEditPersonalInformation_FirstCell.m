//
//  FirstEditCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/29/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellForEditPersonalInformation_FirstCell.h"

@implementation CellForEditPersonalInformation_FirstCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.touXiang];
        [self.contentView addSubview:self.staticLabel];
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

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.size.width -= 2 * 10;
    frame.size.height = 64;
    [super setFrame:frame];
}

- (UIButton *)touXiang
{
    if (!_touXiang) {
        _touXiang = [[UIButton alloc] initWithFrame:CGRectMake(100,4,55,55)];
        [_touXiang setBackgroundImage:[UIImage imageNamed:@"persontx.png"] forState:UIControlStateNormal];
    }
    return _touXiang;
}

- (UILabel *)staticLabel
{
    if (!_staticLabel)
    {
        _staticLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.origin.y, 70, self.frame.size.height)];
    }
    return _staticLabel;
}

@end
