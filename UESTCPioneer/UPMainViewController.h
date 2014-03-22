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

@interface UPMainViewController : UIViewController{
    //用于显示未读消息和样式
    NSString *UnreadKey;
        UIRefreshControl *refreshControl;
    
    ///用于tableview数据
        NSArray *tableViewEntitiesArray;
}
@property (nonatomic,strong)UPTableView *tableView;
-(void)leftBarButtonAction:(UIButton*)button;

///用于下拉更新的请求，每次下拉更新会调用此函数，让子类继承
-(void)refreshRequest;

@end
