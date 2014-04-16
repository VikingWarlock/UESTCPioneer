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
    NSDictionary * detailData;
}

@property (nonatomic,strong) NSArray * data;


@end

@implementation OrganTableViewController

static  NSString *CellTableIdentifier = @"CellTableIdentifier";

- (id)initWithRequestData:(NSDictionary*)RequestData EntityName:(NSString *)EntityName Mapping:(NSDictionary*)Mapping{
    if (self) {
        self.title = @"组织架构";
        NSString * requestUrl = @"http://222.197.183.81:8080/UestcApp/ieaction.do?type=getInstitute";
        NSURL * url = [NSURL URLWithString:requestUrl];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            detailData = (NSDictionary*)JSON;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"加载失败");
        }];
        
    }
    return self;
}
/*    NSString *weatherUrl = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
 NSURL *url = [NSURL URLWithString:weatherUrl];
 NSURLRequest *request = [NSURLRequest requestWithURL:url];
 
 // 2
 AFJSONRequestOperation *operation =
 [AFJSONRequestOperation JSONRequestOperationWithRequest:request
 // 3
 success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
 self.weather  = (NSDictionary *)JSON;
 self.title = @"JSON Retrieved";
 [self.tableView reloadData];
 }
 // 4
 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
 message:[NSString stringWithFormat:@"%@",error]
 delegate:nil
 cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [av show];
 */

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
    NSString * requestUrl = @"http://222.197.183.81:8080/UestcApp/ieaction.do?type=getInstitute";
    NSURL * url = [NSURL URLWithString:requestUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        detailData = (NSDictionary*)JSON;
        if(detailData == nil) {
            NSLog(@"aaaaaaa");
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"加载失败");
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
    NSArray * detailArr;
    if (indexPath.row == 0) {
        detailArr = detailData[@"content1"];
    }else
        detailArr = detailData[@"content2"];
    UIViewController * viewController = [[OrganDetailTableViewController alloc] initWithArray:detailArr];
    [self.navigationController pushViewController:viewController animated:YES];
}



@end
