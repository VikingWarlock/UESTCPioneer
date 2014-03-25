//
//  UPMainViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPMainViewController.h"

@interface UPMainViewController (){
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
    self.tableView=[[UPTableView alloc]initWithFrame:CGRectMake(10, 35, 300, 420) style:UITableViewStyleGrouped];
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

@end
