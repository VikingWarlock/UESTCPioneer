//
//  commentView.m
//  UESTCPioneer
            //
//  Created by Sway on 14-3-23.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "commentView.h"

@interface commentView(){
    UIView *commentRectView;
    UIButton *closeButton,*commitButton;
    UITextField *commentTextField;
    UILabel *titleLabel;

}

@end

@implementation commentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        
    }
    return self;
}

-(id)init{
    self  =[super init];
    if (self){
        [self _viewsLayout];
        [self _viewsStyle];
        titleLabel.text=@"请评论";
        [closeButton setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
        [commitButton setImage:[UIImage imageNamed:@"complete2.png"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [commitButton addTarget:self action:@selector(commitButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
    
}

-(void)_viewsStyle{
    [commentTextField.layer setBorderWidth:1];
    [commentTextField.layer setBorderColor:[UIColor colorWithWhite:0.9 alpha:0.9].CGColor];
    [commentTextField setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    
}

-(void)_viewsLayout{

    
    
    
    //把评论框＋到背景上
    commentRectView=[[UIView alloc]init];
    [commentRectView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:commentRectView];
    
    //设置评论外框的布局
    [commentRectView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[commentRectView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commentRectView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[commentRectView(==180)]-216-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commentRectView)]];
    
    //文本框
    commentTextField = [[UITextField alloc]init];
    [commentRectView addSubview:commentTextField];
    [commentTextField  setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[commentTextField]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commentTextField)]];
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[commentTextField]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commentTextField)]];
    
    //取消按钮
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentRectView addSubview:closeButton];
    [closeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[closeButton(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(closeButton)]];
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[closeButton(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(closeButton)]];
    
    
    //提交按钮
    commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentRectView addSubview:commitButton];
    [commitButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[commitButton(==44)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commitButton)]];
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[commitButton(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commitButton)]];
    
    //标题
    titleLabel = [[UILabel alloc]init];
    [commentRectView addSubview:titleLabel];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[titleLabel(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel)]];
    
    [commentRectView addConstraint:[NSLayoutConstraint constraintWithItem:commentRectView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:titleLabel attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
}

-(void)popUpCommentViewWithCommitBlock:(void(^)(NSString *commentBody))commitBlock{
        UIView *keyWindow=[[UIApplication sharedApplication]keyWindow];
    
    //把self加到window
    [keyWindow addSubview:self];
    [self setBackgroundColor:[UIColor redColor]];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [keyWindow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    [keyWindow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    
    [self setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.8]];

//    commentView *comment=[[commentView alloc]init];
    self.commitBlock=commitBlock;
    [self setAlpha:0];
    
    [UIView beginAnimations:nil context:NULL];
    [self setAlpha:1];
    [UIView commitAnimations];
    
/*    （1）type：writeShareComment  （2）user_id：用户的账号
    （3）username：用户姓名      （4）shareId：活动分享的id
    （5）comment：评论的内容
 */
}

-(void)closeCommentView{
    [self closeButtonPress:Nil];
}


-(void)closeButtonPress:(UIButton*)button{
    [UIView animateWithDuration:0.25 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)commitButtonPress:(UIButton*)button{
    
    self.commitBlock(commentTextField.text);
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
