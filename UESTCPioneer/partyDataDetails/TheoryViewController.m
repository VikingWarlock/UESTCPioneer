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
    NSDictionary * requestData;
    NSString * entityName;
    NSDictionary *mapping;
}
@property (strong) NSArray * tableViewEntitiseArray;

@end

@implementation TheoryViewController

static NSString *CellTableIdentifier = @"CellTableIdentifier";

- (id)initWithTitle:(NSString *)title RequestData:(NSDictionary*)RequestData EntityName:(NSString *)EntityName Mapping:(NSDictionary*)Mapping{
    if (self) {
        self.title = title;
        requestData = RequestData;
        entityName = EntityName;
        mapping = Mapping;
        
        //tableViewEntitiseArray = [[NSArray alloc ] initWithArray:[TheoryViewController downloadDataWithRequestData:RequestData EntityName:EntityName Mapping:Mapping]];
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
    [self downloadDataWithRequestData:requestData EntityName:entityName Mapping:mapping];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height-65) style:UITableViewStylePlain];
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
    
    //return [self.data count];
    return [self.tableViewEntitiseArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cells *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell == nil){
        cell = [[Cells alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
    }
    PartyDataSpiritEntity *entity = self.tableViewEntitiseArray[indexPath.row];
    cell.titleValue.text = entity.title;
    cell.contentValue.text = entity.desc;
    cell.timeValue.text = entity.time;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cells * cell = (Cells *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.timeValue.frame.origin.y + cell.timeValue.frame.size.height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PartyDataSpiritEntity * entity = self.tableViewEntitiseArray[indexPath.row];
    NSDictionary * detailData = @{@"title": entity.title,@"content":entity.content};
    
    //NSDictionary * detailData;
    //if ([self.data[indexPath.row] isKindOfClass:[NSDictionary class]]) {
    //    detailData = self.data[indexPath.row];
    //}
    UIViewController * viewController = [[TheoryDetailViewController alloc] initWithDictionary:detailData];
    [self.navigationController pushViewController:viewController animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)downloadDataWithRequestData:(NSDictionary*)RequestData EntityName:(NSString *)EntityName Mapping:(NSDictionary*)Mapping{
    [PublicMethod ClearEntity:EntityName];
    [NetworkCenter RKRequestWithData:RequestData EntityName:EntityName Mapping:Mapping SuccessBlock:^(NSArray *resultArray) {
        NSMutableArray * dic = [[NSMutableArray alloc] init];
        [dic addObjectsFromArray:resultArray];
        self.tableViewEntitiseArray = [[NSArray alloc] initWithArray:dic];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"加载失败");
    }];
    
}

@end
