//
//  commentView.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-23.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface commentView : UIView{
    UIView *commentRectView;
    UIButton *closeButton,*commitButton;
    //UITextView *commentTextField;  将commentTextField写成property供外部调用以自动弹出键盘  张众
    UILabel *titleLabel;

}

@property (nonatomic,copy) void (^commitBlock)(NSString* commentBody);
-(void)popUpCommentViewWithCommitBlock:(void(^)(NSString *commentBody))commitBlock;
-(void)closeCommentView;
@property (nonatomic,strong) UITextView *commentTextField;

@end
