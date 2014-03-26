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


	// Do any additional setup after loading the view.
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    label.text=@"心情分享";
//    label.center=self.view.center;

    

    

    

//    [self.view addSubview:label];
    [self hideTopView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    


//    [self.tableView setPullDownBeginRefreshAction:@selector(refreshRequest:) ];

    
    

    
    
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
        
        
        
        commentButton *btn3 = (commentButton *)[cell3.contentView viewWithTag:btn3Tag];
        [btn3 setTitle:[NSString stringWithFormat:@"%d",[DataEntity.numberOfComment integerValue]] forState:UIControlStateNormal];
        btn3.theId=[DataEntity.theId integerValue];
        
        [btn3 addTarget:self action:@selector(commentButtonPress:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark -  pull Refresh



-(void)pullDownRefresh:(MJRefreshBaseView *)refreshView{
    [NetworkCenter RKRequestWithData:requestTestData EntityName:MoodShareEntityName Mapping:MoodShareMapping SuccessBlock:^(NSArray *resultArray) {
//        for (MoodShareNewsEntity *entity in resultArray){
//            NSLog(@"%d",[entity.theId integerValue]);
//        }
        tableViewEntitiesArray=resultArray;
        [self.tableView reloadData];
        [PublicMethod ClearAllCoreData];
        [refreshView endRefreshing];

        
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
        [refreshView endRefreshing];
    }];
}

-(void)pullUpRefresh:(MJRefreshBaseView *)refreshView{
    
    NSMutableDictionary *tempDic= [[NSMutableDictionary alloc]initWithDictionary:requestTestData];
    [tempDic setObject:@(PullUpRefreshTimes+2) forKey:@"page"];
    
    [NetworkCenter RKRequestWithData:tempDic EntityName:MoodShareEntityName Mapping:MoodShareMapping SuccessBlock:^(NSArray *resultArray) {
        
        
        NSMutableArray *newArray = [[NSMutableArray alloc]initWithArray:tableViewEntitiesArray];
        [newArray addObjectsFromArray:resultArray];
        NSArray *result = [[NSArray alloc]initWithArray:newArray];
        
        
        tableViewEntitiesArray=result;
        [self.tableView reloadData];
        [PublicMethod ClearAllCoreData];
        [refreshView endRefreshing];
        PullUpRefreshTimes++;
        
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
        [refreshView endRefreshing];
    }];
}

#pragma mark - commentButton press

-(void)commentButtonPress:(commentButton*)button{
    commentViewController *comment = [[commentViewController alloc]init];
    
    
//    1）type：writeShareComment  （2）user_id：用户的账号
//    （3）username：用户姓名      （4）shareId：活动分享的id
//    （5）comment：评论的内容

    
    
    //请求评论列表用的参数
    comment.commentListRequestData=@{@"type":@"getShareComment",@"page":@"1",@"shareId":[NSString stringWithFormat:@"%d",button.theId]};
    
    
    //写评论请求用的参数
    comment.commentRequestData=@{@"type":@"writeShareComment",@"user_id":[constant getUserId],@"username":[constant getUserName],@"shareId":[NSString stringWithFormat:@"%d",button.theId],@"comment":@""};
    
//    comment.theId=button.theId;
    comment.numberOfComment=[button.titleLabel.text integerValue];
    [self.leveyTabBarController.navigationController pushViewController:comment animated:YES];
}

@end
