//
//  UPMainInfoCell.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

#define wordsTag          2
#define wordsFontSize    16
@protocol UPMainInfoCellDelegate<NSObject>
@optional
-(void)WholeNewsButtonClick:(NSInteger)theId;

@end

@interface UPMainInfoCell : UITableViewCell
-(void)setNewsBody:(NSString*)newsBody;
@property (nonatomic)NSInteger theId;
@property (nonatomic,weak)id<UPMainInfoCellDelegate>delegate;

@end