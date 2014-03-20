//
//  UPMainViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPMainViewController.h"
#import "PPRevealSideViewController.h"

@interface UPMainViewController (){
    UIButton *barButton;
}

@end

@implementation UPMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView=[[UPTableView alloc]initWithFrame:CGRectMake(10, 0, 300, 455) style:UITableViewStyleGrouped];
    if(IS_IOS7)
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setAllowsSelection:NO]; 
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 455)];
    [background setBackgroundColor:self.tableView.backgroundColor];
    [self.view addSubview:background];
    [self.view addSubview:self.tableView];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self _initBarButton];
    
    
    //界面显示，监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationUnreadrefresh:) name:kNotificationUnreadTotalRefreshed object:nil];
    


}


-(void)viewWillDisappear:(BOOL)animated{
        //界面消失，取消接受通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUnreadTotalRefreshed object:nil];
    [self.leveyTabBarController.navigationItem setLeftBarButtonItem:Nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftBarButtonAction:(UIButton*)button{
//    NSLog(@"aa");
    [self.leveyTabBarController.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];

}


///能根据未读消息自动刷新或生成并显示一个barButtonItem
-(void)_initBarButton{
    if (barButton==nil){
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
 
        [b addTarget:self action:@selector(leftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        barButton=b;
    }
    NSInteger unreadTotal=[Unread getUnreadNumWithKey:kUnreadTotalKey];
    
    if (unreadTotal){
        [barButton setImage:[UIImage imageNamed:@"menu_msg.png"] forState:UIControlStateNormal];
        [barButton setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 9, 9)];
    }
    else {
        [barButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
        [barButton setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    }
    UIBarButtonItem *barItem=[helper BarButtonItemWithUIButton:barButton ButtonOrigin:CGPointMake(-10, 0)];
    [self.leveyTabBarController.navigationItem setLeftBarButtonItem:barItem];
}

#pragma mark - Notification 

//未读消息有更新
-(void)notificationUnreadrefresh:(NSNotification*)notify{
    [self _initBarButton];
    
//    [imgDic setObject:[UIImage imageNamed:@"home.png"] forKey:@"Default"];
//	[imgDic setObject:[UIImage imageNamed:@"home_highlighted.png"] forKey:@"Highlighted"];
//	[imgDic setObject:[UIImage imageNamed:@"home_highlighted"]
    
    
    //当前控制器是否有新值
    NSInteger unread= [Unread getUnreadNumWithKey:UnreadKey];
    NSDictionary *dic;
    if (unread){
        
        dic= @{@"Default":[UIImage imageNamed:@"home_msg"],@"Highlighted":[UIImage imageNamed:@"home_highlighted_msg"],@"Seleted":[UIImage imageNamed:@"home_highlighted_msg"]};
    }
    else {
        dic=@{@"Default":[UIImage imageNamed:@"home"],@"Highlighted":[UIImage imageNamed:@"home_highlighted"],@"Seleted":[UIImage imageNamed:@"home_highlighted"]};
    }
    [self.leveyTabBarController setTabBarItemWithImageDicationary:dic ForIndex:0];
}

@end
