//
//  RefreshRequestViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-28.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "RefreshRequestViewController.h"
#import "PioneerNewsEntity.h"
@interface RefreshRequestViewController (){

    

}

@end

@implementation RefreshRequestViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - refresh request
//{"comeCode":"school","comeFrom":"电子科技大学校党委","content":" 3月20日，电子
//    "count":0,"desc":"","id":35,"picName":"","picUrl":{},"time":"2014年03月26日 11:22","title":"新闻测试——百余家用人单位来校揽才","type":"","zipPicUrl":{}},

-(void)pullDownRefresh:(MJRefreshBaseView *)refreshView{
    [PublicMethod ClearEntity:kPioneerEntityName];
    [NetworkCenter RKRequestWithData:requestData EntityName:entityName Mapping:entityMapping SuccessBlock:^(NSArray *resultArray) {
        
        NSMutableArray *dic= [[NSMutableArray alloc]init];
        [dic addObjectsFromArray:resultArray];
        
        tableViewEntitiesArray=[[NSArray alloc]initWithArray:dic];
        
        for (PioneerNewsEntity* entity in tableViewEntitiesArray){
            NSLog(@"%@",entity.titleBody);
        }
        
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
        
        for (PioneerNewsEntity* entity in tableViewEntitiesArray){
            NSLog(@"%@",entity.titleBody);
        }
        
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

@end
