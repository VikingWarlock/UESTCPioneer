//
//  GuideTableViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "GuideTableViewController.h"
#import "GuideDetailViewController.h"

@interface GuideTableViewController ()

@property (nonatomic,strong) NSArray * data;

@end

@implementation GuideTableViewController


static  NSString *CellTableIdentifier = @"CellTableIdentifier";


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(NSArray *)data{
    if (!_data) {
        _data = @[@{@"title":@"111",@"time":@"2014-03-22"},@{@"title":@"申请22",@"time":@"2014-03-22"},@{@"title":@"333",@"time":@"2014-03-22"}];
    }
    return _data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellTableIdentifier];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.title = @"办事指南";
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
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
    }
    NSDictionary * rowData = self.data[indexPath.row];
    cell.textLabel.text = rowData[@"title"];
    cell.textLabel.frame = CGRectMake(0, 0, 200, cell.frame.size.height);
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    UILabel *timeValue = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 80, cell.frame.size.height)];
    timeValue.text = rowData[@"time"];
    timeValue.font = [UIFont systemFontOfSize:13];
    timeValue.textColor = [UIColor grayColor];
    [cell addSubview:timeValue];
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController * viewController = [[GuideDetailViewController alloc] initWithTitle:@"详情"];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
