//
//  shareEditView.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-30.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "commentView.h"

@interface shareEditView : commentView{
UILabel *shareSourceInfoLabel;
}
-(void)popUpCommentViewWithShareSourceInfo:(NSString*)string CommitBlock:(void (^)(NSString *ommentBody))commitBlock;

@end
