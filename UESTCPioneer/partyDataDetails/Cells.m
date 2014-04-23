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
        
        _contentValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 300, 999)];
        _contentValue.textColor = [UIColor grayColor];
        [_contentValue setFont:[UIFont systemFontOfSize:15.0]];
        [_contentValue setNumberOfLines:0];
        [_contentValue setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_contentValue];
        
        _timeValue = [[UILabel alloc] initWithFrame:CGRectMake(230, 85, 80, 20)];
        _timeValue.font = [UIFont systemFontOfSize:15];
        _timeValue.numberOfLines = 1;
        _timeValue.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeValue];
    }
    return self;
}

-(void)setLayoutWithString:(NSString*)content{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName:paragraphStyle};
    self.contentValue.frame = CGRectMake(10, 25, 300, 999);
    CGSize contentSize = [content boundingRectWithSize:self.contentValue.frame.size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    
    _contentValue.frame  = CGRectMake(10, 25, contentSize.width,contentSize.height);
    _timeValue.frame = CGRectMake(230,25 + contentSize.height,80,20);
    
}
/*
 NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
 paragraphStyle.lineBreakMode = self.lineBreakMode;
 paragraphStyle.alignment = self.textAlignment;
 NSDictionary * attributes = @{NSFontAttributeName : self.font,
 NSParagraphStyleAttributeName : paragraphStyle};
 contentSize = [self.text boundingRectWithSize:self.frame.size
 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
 attributes:attributes
 context:nil].size;
 }
 */
@end
