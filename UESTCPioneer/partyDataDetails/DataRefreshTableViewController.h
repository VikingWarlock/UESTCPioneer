//
//  DataRefreshTableViewController.h
//  UESTCPioneer
//
//  Created by 马君 on 14-4-16.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "RefreshTableViewController.h"

@interface DataRefreshTableViewController : RefreshTableViewController{
    NSString * entityName;
    NSDictionary * entityMapping;
    NSDictionary * requestData;
    NSArray * tableViewEntitiesArray;
}
//@property (nonatomic,strong)UPTableView *tableView;
-(void)downloadDataWithRequestData:(NSDictionary *)RequestData EntityName:(NSString*)EntityName Mapping:(NSDictionary *)Mapping;



@end
