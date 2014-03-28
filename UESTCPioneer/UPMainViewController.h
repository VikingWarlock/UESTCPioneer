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
#import "commentButton.h"
#import "commentViewController.h"
#import "RefreshTableViewController.h"
#import "NIDropDown.h"



@interface UPMainViewController : RefreshTableViewController<NIDropDownDelegate>{
    //用于显示未读消息和样式
    NSString *UnreadKey;
    NIDropDown *dropDown;
    UIButton *dropbtn;
    ///用于tableview数据
        NSArray *tableViewEntitiesArray;
}
-(void)leftBarButtonAction:(UIButton*)button;
@property (nonatomic,strong)UPTableView *tableView;
-(void)rel;
-(void)hideTopView;
@end
