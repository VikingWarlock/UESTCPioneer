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
@class  UPFooterCell;
@protocol UPFooterCellDelegate <NSObject>

@optional
-(void)shareButtonClick:(NSInteger)theId;
-(void)UPFooterCell:(UPFooterCell*)cell shareButtonPress:(UIButton*)button;
-(void)UPFooterCell:(UPFooterCell*)cell markButtonClick:(UIButton*)button;
@end


@interface UPFooterCell : UITableViewCell
-(void)addCommentButtonTaget:(id)target Action:(SEL)action;

-(void)setCommentId:(NSInteger)theId;

-(void)setCommentNum:(NSInteger)num;
-(void)setShareNum:(NSInteger)num;

-(void)setShareButtonImage:(UIImage*)image;

-(void)setMarkButtonStatus:(BOOL)status;

@property (nonatomic)NSInteger theId;
@property (nonatomic,weak)id<UPFooterCellDelegate>delegate;
@property(nonatomic) BOOL shareButtonEnable;
@property(nonatomic)BOOL markButtonEnable;
@property(nonatomic)UIButton *markButton;
//用于异步请求的一些判断用途
@property (nonatomic)BOOL shareButtonRequesting;

@end
