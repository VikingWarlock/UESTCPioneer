//
//  superTableViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-4-12.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "superTableViewController.h"
#import "Mapping.h"

@interface superTableViewController ()
@end

@implementation superTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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

-(void)downloadDataWithRequestData:(NSDictionary*)RequestData EntityName:(NSString *)EntityName Mapping:(NSDictionary*)Mapping{
    [PublicMethod ClearEntity:EntityName];
    [NetworkCenter RKRequestWithData:RequestData EntityName:EntityName Mapping:Mapping SuccessBlock:^(NSArray *resultArray) {
        NSMutableArray * dic = [[NSMutableArray alloc] init];
        [dic addObjectsFromArray:resultArray];
        tableViewEntitiseArray = [[NSArray alloc] initWithArray:dic];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"加载失败");
    }];
}


@end
