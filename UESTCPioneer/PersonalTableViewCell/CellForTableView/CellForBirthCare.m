//
//  BirthCareCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/26/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellForBirthCare.h"

@implementation CellForBirthCare

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.date];
        [self.contentView addSubview:self.button];
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

- (UILabel *)date
{
    if (!_date)
    {
        _date = [[UILabel alloc] initWithFrame:CGRectMake(75, 30, 100, 30)];
        _date.font = [UIFont systemFontOfSize:15];
        _date.textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
        _date.text = @"0天后过生日";
    }
    return _date;
}

- (UILabel *)name
{
    if (!_name)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(75, 5, 100, 30)];
        _name.font = [UIFont boldSystemFontOfSize:18];
        _name.text = @"Katherine";
    }
    return _name;
}

- (UIImageView *)image
{
    if(!_image)
    {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(10,4,55,55)];
        _image.image = [UIImage imageNamed:@"touxiang.png"];
    }
    return  _image;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(250, 21, 55,22)];
        [_button setBackgroundImage:[UIImage imageNamed:@"birremind.png" ] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:10];
        [_button addTarget:self action:@selector(sendWish:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"送祝福" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button setTitleEdgeInsets:UIEdgeInsetsMake(1, 18, 1, 1)];
    }
    return _button;
}

- (void)sendWish:(id)sender
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250,17, 60, 30)];
    label.text = @"已送祝福";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
    [((UIButton *)sender).superview.superview addSubview:label];
    [((UIButton *)sender) setFrame:CGRectMake(230, 25, 15, 15)];
    [((UIButton *)sender) setBackgroundImage:[UIImage imageNamed:@"already.png"] forState:UIControlStateNormal];
}

@end
