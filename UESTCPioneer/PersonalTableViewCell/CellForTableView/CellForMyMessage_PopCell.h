//
//  PopCell.h
//  UESTCPioneer
//
//  Created by 张众 on 3/24/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellForMyMessage_PopCell : UITableViewCell
@property (nonatomic,strong) UIImageView *leftImage;
@property (nonatomic,strong) UIImageView *popView;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,assign) BOOL isOpen;
@end
