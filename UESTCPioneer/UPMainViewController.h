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

@interface UPMainViewController : RefreshTableViewController{
    //用于显示未读消息和样式
    NSString *UnreadKey;
    
    ///用于tableview数据
        NSArray *tableViewEntitiesArray;
}
-(void)leftBarButtonAction:(UIButton*)button;



@end
