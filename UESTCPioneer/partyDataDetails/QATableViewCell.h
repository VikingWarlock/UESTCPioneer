//
//  QATableViewCell.h
//  UESTCPioneer
//
//  Created by 马君 on 14-4-18.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartyDataQAEntity.h"

@interface QATableViewCell : UITableViewCell

@property(strong,nonatomic)UILabel * userNameLabel;
@property(strong,nonatomic)UILabel * queTimeLabel;
@property(strong,nonatomic)UILabel * queLabel;
@property(strong,nonatomic)UILabel * ansNameLabel;
@property(strong,nonatomic)UILabel * ansLabel;
@property(strong,nonatomic)UILabel * ansTimeLabel;

@property(strong,nonatomic)UIView * ansView;
@property (strong) PartyDataQAEntity * entity;

-(void)setLayoutWithQue:(NSString*)que Ans:(NSString*)ans;


@end
