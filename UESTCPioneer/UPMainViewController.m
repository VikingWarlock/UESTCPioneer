//
//  UPMainViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPMainViewController.h"

@interface UPMainViewController (){
    UIButton *barButton;

    UIView *dropdownview;
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
    

    
    
    
    


//    [refreshControl setAttributedTitle:[[NSAttributedString alloc]initWithString:@"下拉刷新"]];

    
    //@self.tableView已经在祖先元素里初始化了@黄卓越 2014-3-26 9:16
//    self.tableView=[[UPTableView alloc]initWithFrame:CGRectMake(10, 35, 300, 420) style:UITableViewStyleGrouped];
    if(IS_IOS7)
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setAllowsSelection:NO];
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 455)];
    [background setBackgroundColor:self.tableView.backgroundColor];
    dropdownview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    dropdownview.backgroundColor = [UIColor whiteColor];
    dropbtn = [[UIButton alloc]initWithFrame:CGRectMake(213, 8, 100, 20)];
    [dropbtn setTitle:@"全部" forState:UIControlStateNormal];
    //dropbtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [dropbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[dropbtn setBackgroundColor:[UIColor redColor]];
    [dropbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 15)];
    //[dropbtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    [dropbtn addTarget:self action:@selector(dropClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *xiala = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiala.png"]];
    xiala.frame = CGRectMake(85, 4, 12, 12);
    xiala.tag = 22;
    //[xiala.layer setAffineTransform:CGAffineTransformMakeRotation(0.5f * 3.14159*2)];
    [dropbtn addSubview:xiala];
    [dropdownview addSubview:dropbtn];
    [self.view addSubview:background];
    [self.view addSubview:self.tableView];
    [self.view addSubview:dropdownview];
	// Do any additional setup after loading the view.
    
    
    
    [self _initBarButton];
    
    
    //界面显示，监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationUnreadrefresh:) name:kNotificationUnreadTotalRefreshed object:nil];
}
-(void)hideTopView{
    dropdownview.hidden = YES;
    self.tableView.frame = CGRectMake(10, 5, 300,450);
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //[dropDown release];
    dropDown = nil;
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


-(void)dealloc{
    [self.tableView freeHeaderFooter];
}



@end
