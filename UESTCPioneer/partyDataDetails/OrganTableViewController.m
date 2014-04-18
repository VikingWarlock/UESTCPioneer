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
#import "AFJSONRequestOperation.h"

@interface OrganTableViewController (){
    NSArray * detailArr;
}

@property (nonatomic,strong) NSArray * data;


@end

@implementation OrganTableViewController

static  NSString *CellTableIdentifier = @"CellTableIdentifier";

- (id)initWithRequestData:(NSDictionary*)RequestData EntityName:(NSString *)EntityName Mapping:(NSDictionary*)Mapping{
    if (self) {
        self.title = @"组织架构";
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
        
        NSString * requestUrl = @"http://222.197.183.81:8080/UestcApp/ieaction.do?type=getInstitute";
        NSURL * url = [NSURL URLWithString:requestUrl];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
 //           detailData = (NSDictionary*)JSON;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"加载失败");
        }];
        
        [self.tableView reloadData];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"组织架构";
        // Custom initialization
    }
    return self;
}

-(NSArray *)data{
    if (!_data) {
        _data = @[@{@"title":@"各单位党委",@"image":@"01.png"},@{@"title":@"机关与直属单位党委",@"image":@"02.png"}];
        
    }
    return _data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: CellTableIdentifier];
    
    
    

    [NetworkCenter AFRequestWithData:@{@"type":@"getInstitute"} SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        detailArr = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
        
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
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
    NSDictionary * dic = detailArr[0];
    NSArray * arr;
    if (indexPath.row == 0) {
        arr = dic[@"content1"];
    }
    else{
        arr = dic[@"content2"];
    }
    UIViewController * viewController = [[OrganDetailTableViewController alloc] initWithArray:arr];
    [self.navigationController pushViewController:viewController animated:YES];
}



@end
