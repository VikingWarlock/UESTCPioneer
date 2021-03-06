//
//  UPMainInfoCell.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPCell.h"
#define wordsTag          2
#define wordsFontSize    16
#define imageViewWidth 60
@protocol UPMainInfoCellDelegate<NSObject>
@optional
-(void)WholeNewsButtonClick:(NSInteger)theId;

@end

@interface UPMainInfoCell : UPCell
-(void)setNewsBody:(NSString*)newsBody;
//@property (nonatomic)NSInteger theId;
@property (nonatomic,weak)id<UPMainInfoCellDelegate>delegate;
@property (nonatomic) NSArray *imageUrlArray;
@property(nonatomic) BOOL hasImage;
-(void)setImageUrlArray:(NSArray *)imageUrlArray;
@end