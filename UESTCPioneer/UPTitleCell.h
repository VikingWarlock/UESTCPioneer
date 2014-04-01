//
//  UPTitleCell.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPCell.h"

#define titleTag          1
#define timeTag          2
#define collectTag          3
#define imgTag          4
#define titleFontSize    16
#define timeFontSize    12

@class UPTitleCell;

@protocol UPTitleCellDelegate <NSObject>

@optional
-(void)UPTitleCell:(UPTitleCell*)cell CollectButtonClick:(UIButton*)button;

@end

@interface UPTitleCell :UPCell

-(void)setTitle:(NSString*)title;
-(void)setTime:(NSString*)time;
-(void)setCollectButtonStatus:(BOOL)status;
@property(nonatomic,weak)id<UPTitleCellDelegate>delegate;

///用于异步锁
@property(nonatomic)BOOL collecting;


@property(nonatomic)BOOL CollectButtonEnable;
@end
