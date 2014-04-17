//
//  GuideTableViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "GuideTableViewController.h"
#import "Mapping.h"
#import "GuideDetailViewController.h"
#import "PartyDataGuideEntity.h"
#import "PartyDataGuideDetailEntity.h"

@interface GuideTableViewController (){
    NSMutableArray * detailTableViewEntitiseArray;
}

@property (nonatomic,strong) NSArray * data;

@end

@implementation GuideTableViewController


static  NSString *CellTableIdentifier = @"CellTableIdentifier";


- (id)init
{
    self = [super init];
    if (self) {
        requestData = @{@"type":@"getZhinanList",@"page":@"1"};
        entityName = @"PartyDataGuideEntity";
        entityMapping = [Mapping PartyDataGuideEntityMapping];
        [self downloadDataWithRequestData:requestData EntityName:entityName Mapping:entityMapping];
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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.title = @"办事指南";

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
    if (![detailTableViewEntitiseArray count]) {
        detailTableViewEntitiseArray = [[NSMutableArray alloc]init];
        [PublicMethod ClearEntity:@"PartyDataGuideDetailEntity"];
        for(int i = 1;i <= [tableViewEntitiesArray count];i++){
            [NetworkCenter RKRequestWithData:@{@"type":@"getOneZhinan",@"id":[NSString stringWithFormat:@"%d",i]} EntityName:@"PartyDataGuideDetailEntity" Mapping:[Mapping PartyDataGuideDetailEntityMapping] SuccessBlock:^(NSArray *resultArray) {
                [detailTableViewEntitiseArray addObject:resultArray[0]];
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                NSLog(@"加载失败");
            }];
        }
    }
    return [tableViewEntitiesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
    }
    PartyDataGuideEntity *entity = tableViewEntitiesArray[indexPath.row];
    UILabel *titleValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 210, cell.frame.size.height)];
    titleValue.text = entity.title;
    titleValue.textColor = [UIColor grayColor];
    titleValue.font = [UIFont boldSystemFontOfSize:16];
    [cell addSubview:titleValue];
    UILabel *timeValue = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 80, cell.frame.size.height)];
    timeValue.text = entity.time;
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
    PartyDataGuideEntity *entity = tableViewEntitiesArray[indexPath.row];
    PartyDataGuideDetailEntity *detailEntity = detailTableViewEntitiseArray[indexPath.row];
    UIViewController * viewController = [[GuideDetailViewController alloc] initWithData:@{@"newsTitle":entity.title,@"newsContent":detailEntity.content,@"newsTime":detailEntity.time}];
    [self.navigationController pushViewController:viewController animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
