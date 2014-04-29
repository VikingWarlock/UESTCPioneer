//
//  LearnTableViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "LearnTableViewController.h"
#import "helper.h"
#import "LearnDetailViewController.h"
#import "PartyDataLearnEntity.h"


@interface LearnTableViewController ()

@property (nonatomic,strong) NSArray * data;

@end

@implementation LearnTableViewController

static NSString * CellTableIdentifier = @"CellTableIdentifier";

- (id)initWithRequestData:(NSDictionary *)RequestData entityName:(NSString *)EntityName Mapping:(NSDictionary *)Mapping{
    if (self) {
        requestData = RequestData;
        entityName = EntityName;
        entityMapping = Mapping;
        [self downloadDataWithRequestData:RequestData  EntityName:EntityName Mapping:Mapping];
    }
    return self;
}

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self downloadDataWithRequestData:@{@"type":@"getFilename",@"page":@"1"}EntityName:@"PartyDataLearnEntity" Mapping:[Mapping PartyDataLearnEntityMapping]];

        // Custom initialization
    }
    return self;
}
 */

//-(NSArray *)data{
//    if (!_data) {
//        _data = @[@{@"title":@"aaa",@"leftImage":@"dxfile.png",@"rightImage":@"learnDownload.png"},@{@"title":@"bbbb",@"leftImage":@"dxfile.png",@"rightImage":@"learnDownload.png"}];
//    }
//    return _data;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"党校学习";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellTableIdentifier];
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
    return [tableViewEntitiesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
    }
    //NSDictionary * rowData = self.data[indexPath.row];
    PartyDataLearnEntity * entity = tableViewEntitiesArray[indexPath.row];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 235, cell.frame.size.height)];
    label.text = entity.fileName;
    label.adjustsFontSizeToFitWidth = YES;
    [cell addSubview:label];
    
    UIImage * leftImage = [helper getCustomImage:[UIImage imageNamed:@"dxfile.png"] insets:UIEdgeInsetsMake(45, 0, 90, 65)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:leftImage];
    imageView.frame = CGRectMake(10, 0, 30, cell.frame.size.height);
    [cell.contentView addSubview:imageView];
    cell.indentationLevel = 2;
    cell.indentationWidth = 20.0f;
    UIImage * rightImage = [helper getCustomImage:[UIImage imageNamed:@"learnDownload.png"] insets:UIEdgeInsetsMake(15, 0, 30, 15)];
    UIImageView * rightView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 0, 30, cell.frame.size.height)];
    [rightView setImage:rightImage];
    [cell addSubview:rightView];
    
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PartyDataLearnEntity * entity = tableViewEntitiesArray[indexPath.row];
    UIViewController * viewController = [[LearnDetailViewController alloc ] initWithFileName:entity.fileName];
    [self.navigationController pushViewController:viewController animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
