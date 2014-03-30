//
//  commentButton.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-22.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "commentButton.h"
#define commentButtonTitleColor         [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1]

@interface commentButton()

@end

@implementation commentButton

- (id)initWithFrame:(CGRect)frame WithImage:(UIImage*)image
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *comment = [[UIImageView alloc]initWithImage:image];
        comment.tag=111;
        comment.frame = CGRectMake(5, 2, 24, 24);
        [self addSubview:comment];
        [self setTitle:@"评论" forState:UIControlStateNormal];
        [self setTitleColor:commentButtonTitleColor forState:UIControlStateNormal];
        //        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        
        
        
        [self setBackgroundImage:[helper makeImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [self.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];

    }
    return self;
}

-(void)setButtonImage:(UIImage*)image{
    UIImageView *imageView  = (UIImageView*)[self viewWithTag:111];
    imageView.image=image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
