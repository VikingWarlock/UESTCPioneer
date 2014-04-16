//
//  QAViewController.h
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QAViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic,strong)NSArray * questArr;
@property (nonatomic,strong)NSArray * ansArr;



@end
