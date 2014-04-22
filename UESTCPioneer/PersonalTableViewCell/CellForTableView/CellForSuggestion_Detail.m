//
//  CellForSuggestion_Detail.m
//  UESTCPioneer
//
//  Created by 张众 on 4/18/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellForSuggestion_Detail.h"

@implementation CellForSuggestion_Detail

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.date];
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.content];
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

- (UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 100, 30)];
        _name.textColor = [UIColor colorWithRed:86.0/255.0 green:148.0/255.0 blue:193.0/255.0 alpha:1];
        _name.text = @"xiaoxiao";
        _name.font = [UIFont systemFontOfSize:16];
    }
    return  _name;
}

- (UILabel *)date
{
    if (!_date) {
        _date = [[UILabel alloc] initWithFrame:CGRectMake(180, 5, 140, 30)];
        _date.textColor = [UIColor colorWithRed:86.0/255.0 green:148.0/255.0 blue:193.0/255.0 alpha:1];
        _date.text = @"2012,12,12 12:12:22";
        _date.font = [UIFont systemFontOfSize:14];
    }
    return _date;
}

- (UIImageView *)headImage
{
    if(!_headImage)
    {
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        _headImage.image = [UIImage imageNamed:@"defaultHeadImage.png"];
    }
    return _headImage;
}

- (UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 315, 30)];
        _content.text = @"我只是一串文本";
        _content.textColor = [UIColor grayColor];
    }
    return _content;
}




@end
