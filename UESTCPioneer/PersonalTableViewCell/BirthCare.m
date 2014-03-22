//
//  BirthCare.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "BirthCare.h"
#import "constant.h"
@interface BirthCare ()

@end

@implementation BirthCare

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
    if(IS_IOS7)
        self.tableView.separatorInset = UIEdgeInsetsZero;
    [self setExtraCellLineHidden];
    [self.tableView setAllowsSelection:NO];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"setcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setFrame:CGRectMake(10,4,55,55)];
    imageView.image = [UIImage imageNamed:@"touxiang.png"];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(75, 5, 100, 30)];
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(75, 30, 100, 30)];
    name.font = [UIFont boldSystemFontOfSize:18];
    date.font = [UIFont systemFontOfSize:15];
    date.textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
    name.text = @"徐涛";
    date.text = @"4天后过生日";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(250, 21, 55,22)];
    [button setBackgroundImage:[UIImage imageNamed:@"birremind.png" ] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    [button setTitle:@"送祝福" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(1, 18, 1, 1)];
    
    [cell.contentView addSubview:button];
    [cell.contentView addSubview:name];
    [cell.contentView addSubview:date];
    [cell.contentView addSubview:imageView];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(void)setExtraCellLineHidden
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
