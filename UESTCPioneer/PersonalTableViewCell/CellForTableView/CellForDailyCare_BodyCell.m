//
//  CellForDailyCare_BodyCell.m
//  UESTCPioneer
//
//  Created by 张众 on 3/22/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CellForDailyCare_BodyCell.h"

@implementation CellForDailyCare_BodyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.body];
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.size.width -= 2 * 10;
    [super setFrame:frame];
}

- (UILabel *)body
{
    if (!_body) {
        _body = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 290, 110)];
        [_body setTextAlignment:NSTextAlignmentLeft];
        _body.font = [UIFont systemFontOfSize:16];
        _body.textColor = [UIColor blackColor];
        _body.lineBreakMode = NSLineBreakByWordWrapping;
        _body.numberOfLines = 0;
        _body.text = @"Text";
    }
    return _body;
}
@end
