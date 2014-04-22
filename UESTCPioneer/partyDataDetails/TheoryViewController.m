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
#import "PartyDataSpiritEntity.h"

@interface TheoryViewController (){
//    NSDictionary * requestData;
//    NSString * entityName;
  //  NSDictionary *mapping;
}
//@property (strong) NSArray * tableViewEntitiseArray;

@end

@implementation TheoryViewController

static NSString *CellTableIdentifier = @"CellTableIdentifier";

- (id)initWithTitle:(NSString *)title RequestData:(NSDictionary*)RequestData EntityName:(NSString *)EntityName Mapping:(NSDictionary*)Mapping{
    if (self) {
        self.title = title;
        requestData = RequestData;
        entityName = EntityName;
        entityMapping = Mapping;
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.tableView = [[UPTableView alloc] initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height-65) style:UITableViewStyleGrouped];
//    self.tableView=[[UPTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 400) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
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
    
    //return [self.data count];
    return [tableViewEntitiesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cells *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell == nil){
        cell = [[Cells alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
    }
    PartyDataSpiritEntity *entity = tableViewEntitiesArray[indexPath.row];
    cell.titleValue.text = entity.title;
    cell.contentValue.text = entity.desc;
    cell.timeValue.text = entity.time;
    
    [cell setLayoutWithString:entity.desc];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cells * cell = (Cells *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.timeValue.frame.origin.y + cell.timeValue.frame.size.height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PartyDataSpiritEntity * entity = tableViewEntitiesArray[indexPath.row];
    NSDictionary * detailData = @{@"title": entity.title,@"content":entity.content};
    
    //NSDictionary * detailData;
    //if ([self.data[indexPath.row] isKindOfClass:[NSDictionary class]]) {
    //    detailData = self.data[indexPath.row];
    //}
    UIViewController * viewController = [[TheoryDetailViewController alloc] initWithDictionary:detailData];
    [self.navigationController pushViewController:viewController animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
