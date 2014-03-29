//
//  TheoryViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "TheoryViewController.h"
#import "Cells.h"
#import "TheoryDetailViewController.h"

@interface TheoryViewController ()


@end

@implementation TheoryViewController

static NSString *CellTableIdentifier = @"CellTableIdentifier";

-(NSArray *) data{
    if (!_data) {
        _data = @[@{@"title":@"1",@"content":@"111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111",@"time":@"2014-3-19"},@{@"title":@"2",@"content":@"222222222222222222222222222222222222222222222222222222222222",@"time":@"2014-3-19"}];
    }
    return _data;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"中央精神";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,500) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Cells *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell == nil){
        cell = [[Cells alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
    }
    NSDictionary * rowData = self.data[indexPath.row];
    cell.titleValue.text = rowData[@"title"];
    cell.contentValue.text = rowData[@"content"];
    cell.contentValue.frame = CGRectMake(10, 25, 300, [cell.contentValue.text length]/30*20);
    cell.timeValue.frame = CGRectMake(220,cell.contentValue.frame.origin.y+cell.contentValue.frame.size.height, 80, 20);
    cell.timeValue.text = rowData[@"time"];
    
    // Configure the cell...
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cells * cell = (Cells *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.timeValue.frame.origin.y + cell.timeValue.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController * viewController = [[TheoryDetailViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
