//
//  UPFooterCell.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPFooterCell.h"
#import "commentButton.h"

#define shareButtonImageViewTag 11

@interface UPFooterCell(){
    commentButton *commentBtn,*shareButton;
    UIButton*markButton;
}


@end

@implementation UPFooterCell
@synthesize markButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
#pragma makr 变量初始化
        _shareButtonEnable=NO;
        _shareButtonRequesting=NO;
        
        
        
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

-(void)setShareButtonImage:(UIImage*)image{
    UIImageView *imageView = (UIImageView*)[self viewWithTag:shareButtonImageViewTag];
    [imageView setImage:image];
}

-(void)setShareButtonEnable:(BOOL)shareButtonEnable{
    _shareButtonEnable=shareButtonEnable;
    if (shareButtonEnable){
        if (shareButton!=Nil)return;
        CGRect btn2Rect = CGRectMake(160, 5, 60, 30);
        commentButton *btn2 = [[commentButton alloc]initWithFrame:btn2Rect];
        
        //增加响应事件
        shareButton=btn2;
        
        ///历史原因保留这个函数
        [shareButton addTarget:self action:@selector(shareButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [shareButton addTarget:self action:@selector(UPFooterCell:shareButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        btn2.tag = btn2Tag;
//        btn2.hidden = YES;
        UIImageView *share = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"share.png"]];
        share.frame = CGRectMake(0, 5, 20, 20);
        share.tag = shareButtonImageViewTag;
        [btn2 addSubview:share];
        [btn2 setTitle:@"转发" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [btn2.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn2.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:btn2];

    }
    else {
        [shareButton removeFromSuperview];
        shareButton=nil;
    }
}

#pragma mark markButton
-(void)setMarkButtonEnable:(BOOL)markButtonEnable{
    if (markButtonEnable){
        if (markButton!=nil)return;
        CGRect btn1Rect = CGRectMake(10, 10, 75, 20);
        UIButton *btn1 = [[UIButton alloc]initWithFrame:btn1Rect];
        markButton=btn1;
        btn1.tag = btn1Tag;
        [btn1 addTarget:self action:@selector(markButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //        btn1.hidden = YES;
        //[btn1 setTitle:@"已读" forState:UIControlStateNormal];
        //[btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:btn1];
    }
    else {
        [markButton removeFromSuperview];
        markButton=nil;
    }
}

-(void)markButtonClick:(UIButton*)button{
    button.selected=!button.selected;
    if ([self.delegate respondsToSelector:@selector(UPFooterCell:markButtonClick:)]){
        [self.delegate UPFooterCell:self markButtonClick:button];
    }
    
}

-(void)setMarkButtonStatus:(BOOL)status{
    if (status){
        markButton.selected=YES;
    }
    else {
        markButton.selected=NO;
    }
}


#pragma  delegate 
///历史原因保留这个函数
-(void)shareButtonPress:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(shareButtonClick:)]){
        [self.delegate shareButtonClick:self.theId];
    }
}
-(void)UPFooterCell:(UPFooterCell*)cell shareButtonPress:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(UPFooterCell:shareButtonPress:)]){
        [self.delegate UPFooterCell:self shareButtonPress:button];
    }
}







@end
