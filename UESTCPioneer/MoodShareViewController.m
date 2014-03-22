//
//  MoodShareViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "MoodShareViewController.h"
#import "UPTableView.h"
#import "UPTitleCell.h"
#import "UPMainInfoCell.h"
#import "UPFooterCell.h"
#import "LeveyTabBarController.h"
#import "MoodShareNewsEntity.h"
#define MoodShareMapping @{@"commentNum":@"numberOfComment"\
                            ,@"content":@"newsBody"\
                            ,@"id":@"theId"\
                            ,@"picUrl":@"picUrl"\
                            ,@"time":@"timeAndDate"\
                            ,@"userId":@"userId"\
                            ,@"userName":@"titleBody"\
}

#define requestTestData @{@"type":@"getEventShare",@"userId":@"0010013110361",@"page":@"1"}

#define MoodShareEntityName @"MoodShareNewsEntity"

@interface MoodShareViewController (){

}

@end

@implementation MoodShareViewController

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
    UnreadKey=kUnreadMoodShare;
//    tableViewEntitiesArray=[PublicMethod EntityArrayWithEntityName:MoodShareEntityName];

    

    

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
}

-(void)viewDidAppear:(BOOL)animated{

}





-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leveyTabBarController.navigationItem setTitle:@"活动分享"];
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
    
    
    
    MoodShareNewsEntity *DataEntity=tableViewEntitiesArray[indexPath.section];
    
    if (indexPath.row == 0) {
        static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
        UPTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier];
        if(cell == nil){
            cell = [[UPTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTitleCellIndentifier];
        }
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_head_image.png"]];
        img.frame = CGRectMake(5, 5, 45, 45);
        [cell.contentView addSubview:img];
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:titleTag];
        title.frame = CGRectMake(60, 10, 250, 20);
        title.text = DataEntity.titleBody;
        UILabel *time = (UILabel *)[cell.contentView viewWithTag:timeTag];
        time.frame = CGRectMake(60, 30, 250, 20);
        time.text = [DataEntity.timeAndDate description];
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
        words.text=DataEntity.newsBody;
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

#pragma mark -  pullDown Refresh



-(void)refreshRequest{
    [NetworkCenter RKRequestWithData:requestTestData EntityName:MoodShareEntityName Mapping:MoodShareMapping SuccessBlock:^(NSArray *resultArray) {
//        for (MoodShareNewsEntity *entity in resultArray){
//            NSLog(@"%d",[entity.theId integerValue]);
//        }
        tableViewEntitiesArray=resultArray;
        [self.tableView reloadData];
        [PublicMethod ClearAllCoreData];
        [refreshControl endRefreshing];

        
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

@end
