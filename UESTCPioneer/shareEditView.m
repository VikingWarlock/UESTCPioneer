//
//  shareEditView.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-30.
//  Copyright (c) 2014年 Sway. All rights reserved.
//


#import "shareEditView.h"

@implementation shareEditView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {}
    return self;

}

-(id)init{
    self = [super init];
    if (self){
        
        titleLabel.text=@"转发";
        shareSourceInfoLabel=[[UILabel alloc]init];
        
        [self _viewLayout];
        [self _viewStyle];
        
        
    }
    return self;
}

-(void)_viewLayout{
    [commentRectView addSubview:shareSourceInfoLabel];
    [shareSourceInfoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

    
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[shareSourceInfoLabel]-16-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(shareSourceInfoLabel)]];
    
    [commentRectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[commentTextField]-[shareSourceInfoLabel(==80)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.commentTextField,shareSourceInfoLabel)]];
}

-(void)_viewStyle{
    [shareSourceInfoLabel.layer setBorderWidth:1];
    [shareSourceInfoLabel.layer setBorderColor:[UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:0.3].CGColor];
    [shareSourceInfoLabel setBackgroundColor:[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1]];
    [shareSourceInfoLabel setNumberOfLines:2];
    [shareSourceInfoLabel setFont:[UIFont systemFontOfSize:20]];

}

-(void)popUpCommentViewWithShareSourceInfo:(NSString*)string CommitBlock:(void (^)(NSString *ommentBody))commitBlock{
    shareSourceInfoLabel.text=string;
    [super popUpCommentViewWithCommitBlock:^(NSString *commentBody) {
        commitBlock(commentBody);
    }];
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
