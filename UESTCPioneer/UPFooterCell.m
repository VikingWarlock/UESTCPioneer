//
//  UPFooterCell.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPFooterCell.h"
#import "commentButton.h"

@interface UPFooterCell(){
    commentButton *commentBtn,*shareButton;
}

@end

@implementation UPFooterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect btn1Rect = CGRectMake(10, 10, 75, 20);
        UIButton *btn1 = [[UIButton alloc]initWithFrame:btn1Rect];
        btn1.tag = btn1Tag;
        btn1.hidden = YES;
        //[btn1 setTitle:@"已读" forState:UIControlStateNormal];
        //[btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:btn1];
        
        CGRect btn2Rect = CGRectMake(160, 5, 60, 30);
        commentButton *btn2 = [[commentButton alloc]initWithFrame:btn2Rect];
        
        //增加响应事件
        shareButton=btn2;
        [shareButton addTarget:self action:@selector(shareButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        btn2.tag = btn2Tag;
        btn2.hidden = YES;
        UIImageView *share = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"share.png"]];
        share.frame = CGRectMake(0, 5, 20, 20);
        share.tag = 11;
        [btn2 addSubview:share];
        [btn2 setTitle:@"转发" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [btn2.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn2.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:btn2];
        
        CGRect btn3Rect = CGRectMake(230, 5, 60, 30);
        commentButton *btn3 = [[commentButton alloc]initWithFrame:btn3Rect];
        
        commentBtn=btn3;
        
        
        btn3.tag = btn3Tag;
        UIImageView *comment = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment.png"]];
        comment.frame = CGRectMake(0, 5, 20, 20);
        [btn3 addSubview:comment];
        [btn3 setTitle:@"评论" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [btn3.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn3.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:btn3];

    }
    return self;
}

-(void)setNumberOfComment:(NSInteger)number{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#warning 评论用了事件响应函数，而转发按钮用了代理，两者不一样

-(void)addCommentButtonTaget:(id)target Action:(SEL)action{
    commentButton *btn = (commentButton*)[self viewWithTag:btn3Tag];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

-(void)setCommentId:(NSInteger)theId{
    commentButton *btn = (commentButton*)[self viewWithTag:btn3Tag];
    btn.theId=theId;
}


-(void)setCommentNum:(NSInteger)num{
        [commentBtn setTitle:[NSString stringWithFormat:@"%d",num] forState:UIControlStateNormal];
}

#pragma mark shareButton

-(void)setShareNum:(NSInteger)num{
    [shareButton setTitle:[NSString stringWithFormat:@"%d",num] forState:UIControlStateNormal];
}


-(void)shareButtonPress:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(shareButtonClick:)]){
        [self.delegate shareButtonClick:self.theId];
    }
}




@end
