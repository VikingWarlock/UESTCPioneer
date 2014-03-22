//
//  PublicityViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "PublicityViewController.h"
#import "UPTableView.h"
#import "UPTitleCell.h"
#import "UPMainInfoCell.h"
#import "UPFooterCell.h"
#import "LeveyTabBarController.h"

@interface PublicityViewController ()

@end

@implementation PublicityViewController

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
    UnreadKey=kUnreadPublicity;
	// Do any additional setup after loading the view.
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    label.text=@"公示公告";
//    label.center=self.view.center;
    

//    [self.view addSubview:label];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
            [self.leveyTabBarController.navigationItem setTitle:@"公示公告"];
}

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

//表的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
        UPTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier];
        if(cell == nil){
            cell = [[UPTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTitleCellIndentifier];
        }
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:titleTag];
        title.text = @"title";
        UILabel *time = (UILabel *)[cell.contentView viewWithTag:timeTag];
        time.text = @"time";
        return cell;
    }
    else if (indexPath.row == 1) {
        static NSString *customMainCellIndentifier = @"CustomMainCellIndentifier";
        UPMainInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:customMainCellIndentifier];;
        if(cell2 == nil){
            cell2 = [[UPMainInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customMainCellIndentifier];
        }
        UILabel *words = (UILabel *)[cell2.contentView viewWithTag:wordsTag];
        words.text = @"在讨论这部纪录片之前，为了避免现在中文网络江湖盛行的动机论，我先要说明：我和崔永元老师没有个人恩怨，相反，对他的主持功力和以前取得的成绩都非常钦佩。我们也至少有一名共同的好朋友，《读库》的出版人张立宪。";
        return cell2;
    }
    else {
        static NSString *customFooterCellIndentifier = @"CustomFooterCellIndentifier";
        UPFooterCell *cell3 = [tableView dequeueReusableCellWithIdentifier:customFooterCellIndentifier];;
        if(cell3 == nil){
            cell3 = [[UPFooterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customFooterCellIndentifier];
        }
        UIButton *btn3 = (UIButton *)[cell3.contentView viewWithTag:btn3Tag];
        return cell3;
    }
    
}

//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 55;
    }
    else if (indexPath.row == 1){
        return 110;
    }
    else
        return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    // indexPath.section,根据分组进行更精确的配置
    return 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 
 &type=getNoticeOrAnnounce&typepid=1&page=1&userid=0100001110011
 typepid用于表示请求的是通知还是公示。1为通知0为公示
 
 
 */

//#define testData @{@"getNotice"}

-(void)refreshRequest{
//    [NetworkCenter RKRequestWithData:<#(NSDictionary *)#> EntityName:<#(NSString *)#> Mapping:<#(NSDictionary *)#> SuccessBlock:<#^(NSArray *resultArray)successBlock#> failure:<#^(NSError *error)failureBlock#>]
    [refreshControl endRefreshing];
}

@end
