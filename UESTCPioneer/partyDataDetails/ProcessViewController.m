//
//  OrganTableViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "ProcessViewController.h"
#import "helper.h"
#import "PartyDataProcessEntity.h"
#import "TheoryDetailViewController.h"


@interface ProcessViewController (){
    NSMutableArray * tableViewEntitiseArray;
}

@property (nonatomic,strong) NSArray * data;

@end

@implementation ProcessViewController

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
        _data = @[@{@"title":@"入党积极分子",@"image":@"01.png"},
                  @{@"title":@"预备党员",@"image":@"02.png"},
                  @{@"title":@"正式党员",@"image":@"03.png"}];
    }
    return _data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"入党流程";
    for (NSString * dangType  in @[@"2",@"3",@"1"]) {
        tableViewEntitiseArray = [[NSMutableArray alloc] init];
        [NetworkCenter RKRequestWithData:@{@"type":@"getParty",@"dangType":dangType} EntityName:@"PartyDataProcessEntity" Mapping:[Mapping PartyDataProcessEntityMapping] SuccessBlock:^(NSArray *resultArray) {
            [tableViewEntitiseArray addObject:resultArray[0]];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            NSLog(@"加载失败");
        }];
    }

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: CellTableIdentifier];
    
    // [self.tableView setFrame:CGRectMake(0, 0, 320, 300)];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
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

    PartyDataProcessEntity * entity = tableViewEntitiseArray[indexPath.row];
    NSDictionary * dic = @{@"title": entity.title,@"content":entity.content};
    UIViewController * viewController = [[TheoryDetailViewController alloc] initWithDictionary:dic ];
    [self.navigationController pushViewController:viewController animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
/*
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
*/

@end
