//
//  Cells.m
//
//
//  Created by 马君 on 14-3-27.
//
//

#import "Cells.h"

@implementation Cells


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _titleValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 20)];
        _titleValue.font = [UIFont boldSystemFontOfSize:20];
        _titleValue.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleValue];
        
        _contentValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 300, 60)];
        _contentValue.font = [UIFont systemFontOfSize:15];
        _contentValue.numberOfLines = 3;
        _contentValue.textColor = [UIColor grayColor];
        [self.contentView addSubview:_contentValue];
        
        _timeValue = [[UILabel alloc] initWithFrame:CGRectMake(230, 85, 80, 20)];
        _timeValue.font = [UIFont systemFontOfSize:15];
        _timeValue.numberOfLines = 1;
        _timeValue.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeValue];
        
    }
    return self;
}


@end
