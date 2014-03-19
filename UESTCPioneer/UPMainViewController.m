//
//  UPMainViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPMainViewController.h"
#import "PPRevealSideViewController.h"

@interface UPMainViewController ()

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
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [b setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    [b addTarget:self action:@selector(leftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem=[helper BarButtonItemWithUIButton:b ButtonOrigin:CGPointMake(-10, 0)];
    [self.leveyTabBarController.navigationItem setLeftBarButtonItem:barItem];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.leveyTabBarController.navigationItem setLeftBarButtonItem:Nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftBarButtonAction:(UIButton*)button{
    NSLog(@"aa");
    [self.leveyTabBarController.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];

}

@end
