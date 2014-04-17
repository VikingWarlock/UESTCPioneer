//
//  DataRefreshTableViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-4-16.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "DataRefreshTableViewController.h"
#import "Mapping.h"


@interface DataRefreshTableViewController ()

@end

@implementation DataRefreshTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)_loadUPTableView{
    self.tableView=[[UPTableView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height-65) style:UITableViewStyleGrouped];
    self.tableView.tag = 27;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pullDownRefresh:(MJRefreshBaseView *)refreshView{
    [PublicMethod ClearEntity:entityName];
    [NetworkCenter RKRequestWithData:requestData EntityName:entityName Mapping:entityMapping SuccessBlock:^(NSArray *resultArray) {
        
        NSMutableArray *dic= [[NSMutableArray alloc]init];
        [dic addObjectsFromArray:resultArray];
        
        tableViewEntitiesArray=[[NSArray alloc]initWithArray:dic];
        
        //        for (PioneerNewsEntity* entity in tableViewEntitiesArray){
        //            NSLog(@"%@",entity.titleBody);
        //        }
        
        //        [PublicMethod ClearEntity:entityName];
        [self.tableView reloadData];
        PullUpRefreshTimes=0;
        [refreshView endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@ 下拉请求失败",entityName);
        [refreshView endRefreshing];
    }];
}

-(void)pullUpRefresh:(MJRefreshBaseView *)refreshView{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:requestData];
    [dic setObject:[NSString stringWithFormat:@"%d",PullUpRefreshTimes+2] forKey:@"page"];
    
    
    
    [NetworkCenter RKRequestWithData:dic EntityName:entityName Mapping:entityMapping SuccessBlock:^(NSArray *resultArray) {
        
        
        if ([resultArray count]==0){
            [refreshView endRefreshing];
            return ;
        }
        
        NSMutableArray *newArray = [[NSMutableArray alloc]init];
        [newArray addObjectsFromArray:tableViewEntitiesArray];
        [newArray addObjectsFromArray:resultArray];
        NSArray *result = [[NSArray alloc]initWithArray:newArray];
        
        
        tableViewEntitiesArray=result;
        
        //        [PublicMethod ClearEntity:entityName];
        [self.tableView reloadData];
        
        //清除core data 因为现在还没有适合下拉刷新和适合本地缓存的api
        
        [refreshView endRefreshing];
        PullUpRefreshTimes++;
        
    } failure:^(NSError *error) {
        NSLog(@"%@ 上拉error:%@",entityName,error);
        [refreshView endRefreshing];
    }];
}

-(void)downloadDataWithRequestData:(NSDictionary*)RequestData EntityName:(NSString *)EntityName Mapping:(NSDictionary*)Mapping{
    [PublicMethod ClearEntity:EntityName];
    [NetworkCenter RKRequestWithData:RequestData EntityName:EntityName Mapping:Mapping SuccessBlock:^(NSArray *resultArray) {
        NSMutableArray * dic = [[NSMutableArray alloc] init];
        [dic addObjectsFromArray:resultArray];
        tableViewEntitiesArray = [[NSArray alloc] initWithArray:dic];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"加载失败");
    }];
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
