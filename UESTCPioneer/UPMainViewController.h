//
//  UPMainViewController.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constant.h"
#import "UPTableView.h"


@interface UPMainViewController : UIViewController{
    //用于显示未读消息和样式
    NSString *UnreadKey;
}
@property (nonatomic,strong)UPTableView *tableView;
-(void)leftBarButtonAction:(UIButton*)button;
@end
