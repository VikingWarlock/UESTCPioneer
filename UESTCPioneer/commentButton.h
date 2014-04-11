//
//  commentButton.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-22.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentButton : UIButton
- (id)initWithFrame:(CGRect)frame WithImage:(UIImage*)image;
-(void)setButtonImage:(UIImage*)image;
///用于网络请求的Id
@property NSInteger theId;
@end
