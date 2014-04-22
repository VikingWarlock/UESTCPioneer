//
//  PopCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/24/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellForMyMessage_PopCell.h"

@implementation CellForMyMessage_PopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.leftImage];
        self.isOpen = NO;
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
        _leftImage.center = CGPointMake(20, 22);
        _leftImage.image = [UIImage imageNamed:@"mm.png"];
    }
    return _leftImage;
}

- (UILabel *)title
{
    if(!_title)
    {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 280, 44)];
        _title.text = @"text";
    }
    return _title;
}

- (UIImageView *)popView
{
    if (!_popView) {
        _popView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 34, 320, 40)];
        _popView.image = [UIImage imageNamed:@"msgbg.png"];
    }
    return _popView;
}

- (UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, 320, 30)];
        _content.textColor = [UIColor whiteColor];
        [_popView addSubview:_content];
    }
    return _content;
}

- (void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    if (_isOpen) {
        [self.contentView addSubview:self.popView];
    }
    else
        [self.popView removeFromSuperview];
}

@end
