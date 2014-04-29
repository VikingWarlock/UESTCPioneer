//
//  QATableViewCell.m
//  UESTCPioneer
//
//  Created by 马君 on 14-4-18.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "QATableViewCell.h"

#define fontColor [UIColor colorWithWhite:132.0/255.0 alpha:1]

@implementation QATableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    //    self.entity = entity;
    //    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 10, 250, 20)];
        _userNameLabel.textColor = [UIColor colorWithRed:82.0/255.0 green:155.0/255.0 blue:196.0/255.0 alpha:1];
        _userNameLabel.font = [UIFont systemFontOfSize:15];
        
        _queTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 5, 120, 20)];
        _queTimeLabel.textColor = fontColor;
        _queTimeLabel.adjustsFontSizeToFitWidth = YES;
        
        _queLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 37, 300, 999)];
        _queLabel.textColor = [UIColor blackColor];
        [_queLabel setNumberOfLines:0];
        _queLabel.font = [UIFont systemFontOfSize:16];

        _ansView = [[UIView alloc] initWithFrame:CGRectMake(10, 55, 300, 90)];
        _ansView.backgroundColor = [UIColor whiteColor];
        
        _ansNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 260, 15)];
        _ansNameLabel.textColor = [UIColor blackColor];
        _ansNameLabel.font = [UIFont systemFontOfSize:16];


        
        _ansLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 260, 999)];
        _ansLabel.textColor = [UIColor blackColor];
        _ansLabel.font = [UIFont systemFontOfSize:16];
        [_ansLabel setNumberOfLines:0];


        
        _ansTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 65, 140, 20)];
        _ansTimeLabel.adjustsFontSizeToFitWidth = YES;
        _ansTimeLabel.textColor = fontColor;

        
        [self.contentView addSubview:_userNameLabel];
        [self.contentView addSubview:_queTimeLabel];
        [self.contentView addSubview:_queLabel];
        [self.contentView addSubview:_ansView];
        [self.contentView addSubview:self.userIcon];
        
        [_ansView addSubview:_ansNameLabel];
        [_ansView addSubview:_ansLabel];
        [_ansView addSubview:_ansTimeLabel];
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

-(void)setLayoutWithQue:(NSString*)que Ans:(NSString*)ans{

    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSParagraphStyleAttributeName:paragraphStyle};
    self.queLabel.frame = CGRectMake(self.queLabel.frame.origin.x, self.queLabel.frame.origin.y, 300, 999);
    CGSize queLabelSize = [que boundingRectWithSize:self.queLabel.frame.size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    self.queLabel.frame = CGRectMake(self.queLabel.frame.origin.x , self.queLabel.frame.origin.y, queLabelSize.width, queLabelSize.height);
    
    
    self.ansLabel.frame = CGRectMake(self.ansLabel.frame.origin.x, self.ansLabel.frame.origin.y , self.ansLabel.frame.size.width, 999);
    CGSize ansLabelSize = [ans boundingRectWithSize:self.ansLabel.frame.size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    self.ansLabel.frame = CGRectMake(self.ansLabel.frame.origin.x, self.ansLabel.frame.origin.y, ansLabelSize.width, ansLabelSize.height);
    self.ansView.frame = CGRectMake(self.ansLabel.frame.origin.x, self.queLabel.frame.origin.y + self.queLabel.frame.size.height+5, 300, 53 + self.ansLabel.frame.size.height);
    self.ansTimeLabel.frame = CGRectMake(150, self.ansLabel.frame.origin.y + self.ansLabel.frame.size.height + 3, 140, 20);
    
}

-(UIImageView*)userIcon{
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touxiang.png"]];
        _userIcon.frame = CGRectMake(10, 7, 25, 25);
    }
    return _userIcon;
}

@end
