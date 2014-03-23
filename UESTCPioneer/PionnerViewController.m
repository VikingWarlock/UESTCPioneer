//
//  ViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "PioneerViewController.h"
#import "UPTableView.h"
#import "UPTitleCell.h"
#import "UPMainInfoCell.h"
#import "UPFooterCell.h"
#import "constant.h"
#import "LeveyTabBarController.h"
#import "PioneerNewsEntity.h"

@interface PioneerViewController ()

@end

@implementation PioneerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UnreadKey=kUnreadPioneerKey;
//    [self.view setBackgroundColor:[UIColor blackColor]];
        [self.leveyTabBarController.navigationItem setTitle:@"成电视角"];


    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    /*
    //@tableView 自动布局
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
    */
     
    
    NSLog(@"self.view=%f",self.view.bounds.size.height);
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        [self.leveyTabBarController.navigationItem setTitle:@"成电先锋"];
    [helper performBlock:^{
        [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
    } afterDelay:3];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSLog(@"%@",self.leveyTabBarController.navigationController);
//    [self.leveyTabBarController.navigationController setTitle:@"aa"];
//    [self.leveyTabBarController.navigationController.navigationItem setTitle:@"bb"];

    
}

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

//表的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [tableViewEntitiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PioneerNewsEntity *entity = tableViewEntitiesArray[indexPath.section];
    
    if (indexPath.row == 0) {
    static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
    UPTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier];
    if(cell == nil){
        cell = [[UPTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTitleCellIndentifier];
    }
    UILabel *title = (UILabel *)[cell.contentView viewWithTag:titleTag];
        title.text =entity.titleBody;
    UILabel *time = (UILabel *)[cell.contentView viewWithTag:timeTag];
//        time.text = [entity.timeAndDate descriptionWithLocale:[NSLocale systemLocale]];
    return cell;
    }
    else if (indexPath.row == 1) {
        static NSString *customMainCellIndentifier = @"CustomMainCellIndentifier";
        UPMainInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:customMainCellIndentifier];;
        if(cell2 == nil){
            cell2 = [[UPMainInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customMainCellIndentifier];
        }
        UILabel *words = (UILabel *)[cell2.contentView viewWithTag:wordsTag];
//        words.text = @"在讨论这部纪录片之前，为了避免现在中文网络江湖盛行的动机论，我先要说明：我和崔永元老师没有个人恩怨，相反，对他的主持功力和以前取得的成绩都非常钦佩。我们也至少有一名共同的好朋友，《读库》的出版人张立宪。";
        words.text=entity.newsBody;
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

#pragma mark - refresh request



/*
 
 
 page=1&type=getNews
 
 {"content":"","count":0,"desc":"东莞市科技局系统党的群众路线教育实践活动简报第5期","id":26,"picName":"","picUrl":"","time":"2014-03-13 15:36:18","title":"践行群众路线，打造莞韶协同创新平台","type":""},
 */

#define testData @{@"page":@"1",@"type":@"getNews"}
#define mapping @{@"content":@"content"\
                    ,@"count":@"count"\
                    ,@"desc":@"desc"\
                    ,@"id":@"theId"\
                    ,@"picName":@"picName"\
                    ,@"picUrl":@"picUrl"\
                    ,@"time":@"timeAndDate"\
                    ,@"title":@"newsBody"\
                    ,@"type":@"type"\
}
#define PioneerEntityName @"PioneerNewsEntity"



-(void)refreshRequest{
    [refreshControl endRefreshing];
//    [NetworkCenter AFRequestWithData:testData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
//        NSLog(@"%@",resultObject);
//        
//        
//        NSArray *a=[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
//        
//        
//        [refreshControl endRefreshing];
//    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"pioneer request error:%@",error);
//        [refreshControl endRefreshing];
//    }];
    
    
//        [NetworkCenter RKRequestWithData:testData EntityName:PioneerEntityName Mapping:mapping SuccessBlock:^(NSArray *resultArray) {
//            
//            tableViewEntitiesArray=resultArray;
//            [PublicMethod ClearAllCoreData];
//            [self.tableView reloadData];
//            [refreshControl endRefreshing];
//        } failure:^(NSError *error) {
//            NSLog(@"pioneer mapping request error:%@",error);
//            [refreshControl endRefreshing];
//        }];
}

@end
