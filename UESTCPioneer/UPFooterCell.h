//
//  UPFooterCell.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

#define btn1Tag          1
#define btn2Tag          2
#define btn3Tag          3

@protocol UPFooterCellDelegate <NSObject>

@optional
-(void)shareButtonClick:(NSInteger)theId;

@end


@interface UPFooterCell : UITableViewCell
-(void)addCommentButtonTaget:(id)target Action:(SEL)action;

-(void)setCommentId:(NSInteger)theId;

-(void)setCommentNum:(NSInteger)num;

@property (nonatomic)NSInteger theId;
@property (nonatomic,weak)id<UPFooterCellDelegate>delegate;

@end
