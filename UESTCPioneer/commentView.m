//
//  commentView.m
//  UESTCPioneer
            //
//  Created by Sway on 14-3-23.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "commentView.h"

@interface commentView(){


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
    [commentTextField.layer setBorderColor:[UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:0.3].CGColor];
    [commentTextField setBackgroundColor:[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1]];
    
}

-(void)_viewsLayout{

    
    
    
    //把评论框＋到背景上
    commentRectView=[[UIView alloc]init];
    [commentRectView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:commentRectView];
    
    //设置评论外框的布局
    [commentRectView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[commentRectView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commentRectView)]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[commentRectView]-216-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commentRectView)]];
//    constraintRectHeight = [NSLayoutConstraint constraintWithItem:commentRectView attribute:NSLayoutAttributeHeight relatedBy:NSLAyoutAttributeEq toItem:<#(id)#> attribute:<#(NSLayoutAttribute)#> multiplier:<#(CGFloat)#> constant:<#(CGFloat)#>]

    
    
    //文本框
    commentTextField = [[UITextView alloc]init];
    [commentRectView addSubview:commentTextField];
    [commentTextField  setTranslatesAutoresizingMaskIntoConstraints:NO];
    [commentTextField setEditable:YES];
    [commentTextField setFont:[UIFont systemFontOfSize:18]];
    



    
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[commentTextField]-16-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commentTextField)]];
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[commentTextField(==120)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commentTextField)]];
    
    
    //文本框相对于父类view的底部约束
    NSLayoutConstraint *bottomContraint = [NSLayoutConstraint constraintWithItem:commentTextField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:commentRectView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    bottomContraint.priority=10;
    [commentRectView addConstraint:bottomContraint];
//    NSLog(@"%@",commentRectView.constraints);
    
    
    //取消按钮
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentRectView addSubview:closeButton];
    [closeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [closeButton setImageEdgeInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
    
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[closeButton(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(closeButton)]];
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[closeButton(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(closeButton)]];
    
    
    //提交按钮
    
    
    commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentRectView addSubview:commitButton];
    
        [commitButton setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    
    [commitButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[commitButton(==44)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commitButton)]];
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[commitButton(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(commitButton)]];
    
    //标题
    titleLabel = [[UILabel alloc]init];
    [commentRectView addSubview:titleLabel];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[titleLabel(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel)]];
    
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
    if ([commentTextField.text isEqualToString:@""] || commentTextField.text==nil){
        [Alert showAlert:@"请输入内容"];
        return;
    }
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
