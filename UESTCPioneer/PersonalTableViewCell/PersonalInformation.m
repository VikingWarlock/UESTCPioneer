//
//  PersonalInformation.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "PersonalInformation.h"
#import "constant.h"
#import "ShortCell.h"
#import "LeveyTabBarController.h"
#import "EditPersonalInformation.h"
@interface PersonalInformation ()
{
    NSArray *array;
}
@end

@implementation PersonalInformation

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ShortCell class] forCellReuseIdentifier:@"setcell"];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorInset = UIEdgeInsetsZero;
#warning mark - 这样的对齐方式真的好傻逼。。。
    array = @[@"",@"姓       名",@"性       别",@"民       族",@"籍       贯",@"入党时间",@"转正时间",@"政治面貌",@"所属支部"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leveyTabBarController.navigationItem setTitle:@""];
    
    UIImageView *customView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:customView.bounds];
    [customView addSubview:button];
    [button setImage:[UIImage imageNamed:@"write.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(editInformation:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.rightBarButtonItem = right;
    
    self.navigationItem.title = @"个人信息";
}

- (void)editInformation:(id)sender
{
    EditPersonalInformation *edit = [[EditPersonalInformation alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController presentViewController:edit animated:YES completion:NULL];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self.leveyTabBarController.navigationItem setRightBarButtonItem:Nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 4;
        default:
            break;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section)
        return 9;
    else return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"setcell";
    ShortCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0 )
    {
        cell.staticLabel.text = array[indexPath.row];
        UIImageView *imageview = [[UIImageView alloc] init];
        [imageview setFrame:CGRectMake(cell.frame.origin.x ,4,55,55)];
        imageview.image = [UIImage imageNamed:@"touxiang.png"];
        [cell.contentView addSubview:imageview];
    }
    else if (indexPath.section ==1 )
        cell.staticLabel.text = array[indexPath.row + 1];
    else
        cell.staticLabel.text = array[indexPath.row + 5];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.text = @"李强";
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0 ) {
        return nil;
    }
    else if (section ==1 ) {
#warning mark - 对齐方式
        return @"   基本信息";
    }
    else if (section == 2 ) {
        return @"   党员信息";
    }
    else return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!section)
        return 10;
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0 )
    {
        return 64;
    }
    else return 44;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
