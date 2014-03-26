//
//  PopCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/24/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "PopCell.h"

@implementation PopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"msgbg.png"]];
        self.backgroundView = imageView;
        [self addSubview:self.label];
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
        _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 320, self.frame.size.height)];
        _label.textColor = [UIColor whiteColor];
    }
    return _label;
}

@end
