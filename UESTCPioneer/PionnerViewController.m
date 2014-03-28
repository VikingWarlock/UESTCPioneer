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



/*
 comeCode:
 comeFrom:
 content:
 count:
 desc:
 id:
 picName:
 picUrl
 time:
 title:
 type
 zipPicUrl
 
 */






@interface PioneerViewController (){

}

@end

@implementation PioneerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor blackColor]];
        [self.leveyTabBarController.navigationItem setTitle:@"成电视角"];
    UnreadKey=kUnreadPioneerKey;


    
    
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
        [self.leveyTabBarController.navigationItem setTitle:@"成电先锋"];
}

-(void)viewDidAppear:(BOOL)animated{
//    NSLog(@"%@",self.leveyTabBarController.navigationController);
//    [self.leveyTabBarController.navigationController setTitle:@"aa"];
//    [self.leveyTabBarController.navigationController.navigationItem setTitle:@"bb"];

    
}

- (void)dropClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"全部", @"通信", @"计算机", @"微固", @"数学", @"外国语",nil];
    if(dropDown == nil) {
        CGFloat f = 180;
        dropDown = [[NIDropDown alloc]initDropDown:sender :&f :arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
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
    PioneerNewsEntity *entity = tableViewEntitiesArray[indexPath.section];
    
    if (indexPath.row == 0) {
    static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
    UPTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier];
    if(cell == nil){
        cell = [[UPTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTitleCellIndentifier];
    }
    UILabel *title = (UILabel *)[cell.contentView viewWithTag:titleTag];
        title.text = entity.titleBody;
    UILabel *time = (UILabel *)[cell.contentView viewWithTag:timeTag];
        time.text = [entity.timeAndDate description];
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
        
        
        commentButton *btn3 = (commentButton *)[cell3.contentView viewWithTag:btn3Tag];
        [btn3 setTitle:[entity.numberOfComment stringValue] forState:UIControlStateNormal];
        
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
//{"comeCode":"school","comeFrom":"电子科技大学校党委","content":" 3月20日，电子
//    "count":0,"desc":"","id":35,"picName":"","picUrl":{},"time":"2014年03月26日 11:22","title":"新闻测试——百余家用人单位来校揽才","type":"","zipPicUrl":{}},

-(void)pullDownRefresh:(MJRefreshBaseView *)refreshView{
    
    [NetworkCenter RKRequestWithData:@{@"page":@"1",@"type":@"getNews"} EntityName:@"PioneerNewsEntity" Mapping:[Mapping PioneerMapping] SuccessBlock:^(NSArray *resultArray) {
        NSLog(@"%@",resultArray);
        tableViewEntitiesArray=resultArray;
        [PublicMethod ClearEntity:@"PioneerNewsEntity"];
        [self.tableView reloadData];
        [refreshView endRefreshing];
    } failure:^(NSError *error) {
        [refreshView endRefreshing];
    }];
}
-(void)pullUpRefresh:(MJRefreshBaseView *)refreshView{
    [helper performBlock:^{
        [refreshView endRefreshing];
    } afterDelay:0.55];
}

@end
