//
//  OrganTableViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "OrganTableViewController.h"
#import "helper.h"
#import "OrganDetailTableViewController.h"

@interface OrganTableViewController ()
@property(nonatomic,strong) NSArray * data;
@end

@implementation OrganTableViewController

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
        _data = @[@{@"image": @"01.png",@"title":@"各单位党委"},@{@"image":@"02.png",@"title":@"机关与直属单位党委"}];
    }
    return _data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: CellTableIdentifier];
    // [self.tableView setFrame:CGRectMake(0, 0, 320, 300)];
    
    self.title = @"组织架构";
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellTableIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
    }
    NSDictionary * rowData = self.data[indexPath.row];
    UIImage * image =[helper getCustomImage:[UIImage imageNamed:rowData[@"image"]] insets:UIEdgeInsetsMake(23, 0, 47, 25)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(10, 0, 30, cell.frame.size.height);
    [cell.contentView addSubview:imageView];
    cell.indentationLevel = 2;
    cell.indentationWidth = 20.0f;
    cell.textLabel.text = rowData[@"title"];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController * viewController = [[OrganDetailTableViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
