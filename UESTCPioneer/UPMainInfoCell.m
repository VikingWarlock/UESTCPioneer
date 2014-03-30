//
//  UPMainInfoCell.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPMainInfoCell.h"

@implementation UPMainInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect wordsRect = CGRectMake(5, 3, 290, 80);
        UILabel *wordsLabel = [[UILabel alloc]initWithFrame:wordsRect];
        wordsLabel.font = [UIFont systemFontOfSize:wordsFontSize];
        wordsLabel.tag = wordsTag;
        wordsLabel.textColor = [UIColor blackColor];
        wordsLabel.lineBreakMode = NSLineBreakByWordWrapping;
        wordsLabel.numberOfLines = 0;
        [wordsLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:wordsLabel];
        
        CGRect btnRect = CGRectMake(5, 85, 40, 20);
        UIButton *btnLabel = [[UIButton alloc]initWithFrame:btnRect];
        btnLabel.titleLabel.font = [UIFont systemFontOfSize:16];
        btnLabel.tag = 1;

        [btnLabel setTitleColor:[UIColor colorWithRed:0 green:0 blue:0.4 alpha:1] forState:UIControlStateNormal];
        [btnLabel setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] forState:UIControlStateHighlighted];
        [btnLabel setTitle:@"全文" forState:UIControlStateNormal];
        [btnLabel addTarget:self action:@selector(WholeNewsContentButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [btnLabel.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:btnLabel];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setNewsBody:(NSString*)newsBody{
    UILabel *words = (UILabel *)[self.contentView viewWithTag:wordsTag];
    words.text = newsBody;
}

-(void)WholeNewsContentButtonPress:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(WholeNewsButtonClick:)]){
        [self.delegate WholeNewsButtonClick:_theId];
    }
}




@end
