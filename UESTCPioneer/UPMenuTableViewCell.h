//
//  UPMenuTableViewCell.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPMenuTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *newsCountLabel;
-(void)showNewsCountLabel:(NSInteger)counts;
@end
