//
//  PersonalViewController.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPMainViewController.h"
#import "constant.h"

@interface PersonalViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIImageView *topBackground;
@property (nonatomic,strong) UIImageView *headPicture;
@property (nonatomic,strong) UIImage *topBackgroundImage;
@property (nonatomic,strong) UIImage *headPictureImage;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *department;
@property (nonatomic,strong) UITableView *PersonalTableView;

@end
