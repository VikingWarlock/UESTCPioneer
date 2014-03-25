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
#import "NIDropDown.h"

@interface UPMainViewController : UIViewController<NIDropDownDelegate>{
    NIDropDown *dropDown;
    UIButton *dropbtn;
}
@property (nonatomic,strong)UPTableView *tableView;
-(void)rel;
-(void)hideTopView;
@end
