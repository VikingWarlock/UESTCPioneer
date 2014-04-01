//
//  UPMainInfoCell.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPMainInfoCell.h"

#define wholeNewsButtonColor         [UIColor colorWithRed:93.0/255.0 green:107.0/255.0 blue:142.0/255.0 alpha:1]

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
        


        [btnLabel setTitleColor:wholeNewsButtonColor forState:UIControlStateNormal];
        [btnLabel setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
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
        [self.delegate WholeNewsButtonClick:self.theId];
    }
}




@end
