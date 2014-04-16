//
//  EditCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/26/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellForEditPersonalInformation.h"

static int i;
@implementation CellForEditPersonalInformation

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textfield];
        [self.contentView addSubview:self.staticLabel];
        self.textfield.tag = i++;
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
    [super setFrame:frame];
}

- (UILabel *)staticLabel
{
    if (!_staticLabel)
    {
        _staticLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.origin.y, 70, self.frame.size.height)];
    }
    return _staticLabel;
}

- (UITextField *)textfield
{
    if (!_textfield)
    {
        _textfield = [[UITextField alloc] initWithFrame:CGRectMake(100,8, 170, self.frame.size.height-16)];
        _textfield.layer.borderColor = [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1] CGColor];
        _textfield.layer.borderWidth =1.0;
        _textfield.layer.cornerRadius =4.0;
        _textfield.placeholder = @"请输入您的...";
    }
    return _textfield;
}


@end
