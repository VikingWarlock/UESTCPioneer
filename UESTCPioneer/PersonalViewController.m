//
//  PersonalViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved
//

#import "PersonalViewController.h"
#import "LeveyTabBarController.h"
#import "PersonalInformation.h"
#import "MyCollection.h"
#import "CheckForSuggestion.h"
#import "MyMessage.h"
#import "BirthCare.h"
#import "DailyCare.h"
#import "StartActivity.h"
#import "PublishNotice.h"
#import "MyNotice.h"


@interface PersonalViewController ()
{
    NSArray *nameArray;
    NSArray *cellIcon;
    NSArray *pushArray;
}
@end

@implementation PersonalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
//
#pragma mark - view display entranc

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.PersonalTableView.delegate = self;
    self.PersonalTableView.dataSource = self;
    nameArray = @[@"个人信息",@"我的收藏",@"查看意见",@"我的消息",@"生日关怀",@"日常关怀",@"发起活动",@"发布通知",@"我的通知"];
    cellIcon = @[@"inf.png",@"pcollect.png",@"view.png",@"mymsg.png",@"birth.png",@"care.png",@"activity.png",@"sendmsg.png",@"mynotice.png"];
    pushArray = @[@"personalinformation",@"mycollection",@"checkforsuggestion",@"mymessage",@"birthcare",@"dailycare",@"startactivity",@"publishnotice",@"mynotice"];
    //self.PersonalTableView.rowHeight = 42;
    if(IS_IOS7)
        self.PersonalTableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.department];
    [self.view addSubview:self.topBackground];
    [self.view addSubview:self.PersonalTableView];
    [self.view addSubview:self.headPicture];
    [self.view addSubview:self.name];
    [self setPersonalInformation];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.leveyTabBarController.navigationItem setTitle:@"个人"];
        [self.leveyTabBarController.navigationItem setLeftBarButtonItem:nil];
    [self.view setUserInteractionEnabled:YES];
    [self.PersonalTableView setScrollEnabled:YES];
    
    
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:customView.bounds];
    [customView addSubview:button];
    [button setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:customView];
    [self.leveyTabBarController.navigationItem setRightBarButtonItem:right];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.leveyTabBarController.navigationItem setRightBarButtonItem:Nil];
}


- (void)setPersonalInformation
{
    if ((NSString *)[[constant getPersonalInfo] objectForKey:@"headpicture"] != nil)
        self.headPictureImage = [[constant getPersonalInfo] objectForKey:@"headpicture"];
    if ((NSString *)[[constant getPersonalInfo] objectForKey:@"branch"] != nil)
        self.department.text = [[constant getPersonalInfo] objectForKey:@"branch"];
    if ((NSString *)[[constant getPersonalInfo] objectForKey:@"name"] != nil)
        self.name.text = [[constant getPersonalInfo] objectForKey:@"name"];
}//获得个人信息的接口

#pragma mark -datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSString *userId = [constant getUserId];
    NSUInteger flag = [[userId substringFromIndex:userId.length - 1] intValue];//管理员id号末尾是1和2，如果不是管理员则把部分功能隐藏

    if (flag == 0) {
        return 2;
    }
    else
        return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1 :
            return 2;
            break;
        default:
            break;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return IS_IOS7 ? 6 : 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!section)
        return 0.1;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PersonalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    leftImage.center = CGPointMake(32, self.PersonalTableView.rowHeight/2.0);
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text=nameArray[indexPath.row];
            leftImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",cellIcon[indexPath.row]]];
            break;
        case 1 :
            cell.textLabel.text=nameArray[indexPath.row + 4];
            leftImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",cellIcon[indexPath.row + 4]]];
            break;
        case 2:
            cell.textLabel.text=nameArray[indexPath.row + 6];
            leftImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",cellIcon[indexPath.row + 6]]];
        default:
            break;
    }
    [cell.contentView addSubview:leftImage];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id aCell;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    aCell = [[PersonalInformation alloc] initWithStyle:UITableViewStyleGrouped];
                    break;
                case 1:
                    aCell = [[MyCollection alloc] init];
                    break;
                case 2:
                    aCell = [[CheckForSuggestion alloc] init];
                    break;
                case 3:
                    aCell = [[MyMessage alloc] init];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    aCell = [[BirthCare alloc] init];
                    break;
                case 1:
                    aCell = [[DailyCare alloc] init];
                    break;
                    
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    aCell = [[StartActivity alloc] initWithStyle:UITableViewStyleGrouped];
                    break;
                case 1:
                    aCell = [[PublishNotice alloc] init];
                    break;
                case 2:
                    aCell = [[MyNotice alloc] init];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    [self.leveyTabBarController.navigationController pushViewController:aCell animated:YES];
    [self.PersonalTableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - property lazy initialization

- (UIImageView *)topBackground
{
    if (!_topBackground)
    {
        _topBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
        _topBackground.image = [UIImage imageNamed:@"personbg.png"];
    }
    return _topBackground;
}

- (void)setTopBackgroundImage:(UIImage *)topBackgroundImage{
    self.topBackground.image = topBackgroundImage;
}

- (UIImageView *)headPicture
{
    if (!_headPicture)
    {
        _headPicture = [[UIImageView alloc] initWithFrame:CGRectMake(220, 105, 90, 90)];
        _headPicture.layer.shadowOffset = CGSizeMake(0, 3);
        _headPicture.layer.shadowOpacity = 0.9;
        _headPicture.layer.shadowColor = [UIColor blackColor].CGColor;
        _headPicture.image = [UIImage imageNamed:@"persontx.png"];
    }
    return _headPicture;
}

- (void)setHeadPictureImage:(UIImage *)headPictureImage
{
    self.headPicture.image = headPictureImage;
}

- (UITableView *)PersonalTableView{
    if (!_PersonalTableView) {
        _PersonalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.topBackground.frame.size.height+35, 320,247) style:UITableViewStyleGrouped];
    }
    return _PersonalTableView;
}

- (UILabel *)name
{
    if (!_name)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(0,140, 215, 35)];
        _name.textAlignment = NSTextAlignmentRight;
        _name.font = [UIFont systemFontOfSize:18];
        _name.textColor = [UIColor whiteColor];
        _name.text = @"Katherine Pierce";
        if (!IS_IOS7)
            _name.backgroundColor = [UIColor clearColor];
    }
    return _name;
}

- (UILabel *)department
{
    if (!_department)
    {
        _department = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topBackground.frame.size.height, 215, 35)];
        _department.textAlignment = NSTextAlignmentRight;
        _department.font = [UIFont systemFontOfSize:14];
        _department.textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
        _department.text = @"Undefined Department";
        if (!IS_IOS7)
            _department.backgroundColor = [UIColor clearColor];
    }
    return _department;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - logout function 
-(void)logout:(id)sender{
    NSUserDefaults * defaultData = [NSUserDefaults standardUserDefaults];
    [defaultData setBool:NO forKey:@"login"];
    [defaultData synchronize];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"logout" object:nil];
}

@end
