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
#import "commentView.h"
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
	// Do any additional setup after loading the view.
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    label.text=@"公示公告";
//    label.center=self.view.center;
    UnreadKey=kUnreadPublicity;

//    [self.view addSubview:label];

    [self hideTopView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
#pragma mark 请求数据
    entityName=kPublicityNewsEntityName;
    entityMapping=[Mapping PublicityMapping];
    /*
     type=getNoticeOrAnnounce&userId=0004003990022&userName=xiao002&page=1&typepid=0
     
     */
    requestData=@{@"type":@"getNoticeOrAnnounce",@"userId":[constant getUserId],@"userName":[constant getUserName],@"page":@"1",@"typepid":@"0"};
    
    
    
    /*
type=getNoticeOrAnnounce&userId=0004003990022&userName=xiao002&page=1&typepid=0
     
     */
    
    //公告公示没有评论列表，而是直接评论
//    commentListRequestData=@{@"type":@"getNoticeOrAnnouce"
//                             ,@"userId":[constant getUserId]
//                             ,@"userName":[constant getUserName]
//                             ,@"page":@"1"
//                             ,@"typeid":@"0"};
//    
//    commentListKeyMapping=
    
    
    
    /*
     type:writeNAcomment意见反馈；fromusername与fromuserid为评论发布者的用户名与用户userid；theme、content使用utf-8编码；typepid:为1表示为通知评论，0表示为公示意见；注意：typepid为0时theme为所需字段，为1时可以不传送theme
     
     */
    commentWriteRequestData=@{@"type": @"writeNAcomment"
                              ,@"fromusername":[constant getUserName]
                              ,@"fromuserid":[constant getUserId]
                              ,@"typepid":@"0"
                              ,@"gonggaoid":@"0"
                              ,@"theme":@""
                              ,@"content":@""};
    
}


-(void)viewWillAppear:(BOOL)animated{
            [self.leveyTabBarController.navigationItem setTitle:@"公示公告"];
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
    UITableViewCell *cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        
//        static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
//        UPTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier];
//        if(cell == nil){
//            cell = [[UPTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTitleCellIndentifier];
//        }
//        UILabel *title = (UILabel *)[cell.contentView viewWithTag:titleTag];
//        title.text = @"title";
//        UILabel *time = (UILabel *)[cell.contentView viewWithTag:timeTag];
//        time.text = @"time";
        UPTitleCell* cell1=(UPTitleCell *)cell;
        
        return cell1;
    }
    else if (indexPath.row == 1) {
//        static NSString *customMainCellIndentifier = @"CustomMainCellIndentifier";
//        UPMainInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:customMainCellIndentifier];;
//        if(cell2 == nil){
//            cell2 = [[UPMainInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customMainCellIndentifier];
//        }
//        UILabel *words = (UILabel *)[cell2.contentView viewWithTag:wordsTag];
//        words.text = @"在讨论这部纪录片之前，为了避免现在中文网络江湖盛行的动机论，我先要说明：我和崔永元老师没有个人恩怨，相反，对他的主持功力和以前取得的成绩都非常钦佩。我们也至少有一名共同的好朋友，《读库》的出版人张立宪。";
        UPMainInfoCell *cell2= (UPMainInfoCell*)cell;
        
        return cell2;
    }
    else {
//        static NSString *customFooterCellIndentifier = @"CustomFooterCellIndentifier";
//        UPFooterCell *cell3 = [tableView dequeueReusableCellWithIdentifier:customFooterCellIndentifier];;
//        if(cell3 == nil){
//            cell3 = [[UPFooterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customFooterCellIndentifier];
//        }
//        UIButton *btn3 = (UIButton *)[cell3.contentView viewWithTag:btn3Tag];
        
        UPFooterCell *cell3 = (UPFooterCell*)cell;
        
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


/*
 
 &type=getNoticeOrAnnounce&typepid=1&page=1&userid=0100001110011
 typepid用于表示请求的是通知还是公示。1为通知0为公示
 
 
 */

//#define testData @{@"getNotice"}
#pragma mark 公告公示的评论方式不同，在这里重载父类方法
-(void)commentButtonPress:(commentButton *)button{
    commentView *co=[[commentView alloc]init];
    
    [co popUpCommentViewWithCommitBlock:^(NSString *commentBody) {
        
        
        
        //设置评论所需的数据并提交评论
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:commentWriteRequestData];
        [dic setObject:[NSString stringWithFormat:@"%d",button.theId] forKey:@"gonggaoid"];
        PublicityNewsEntity *entity= [PublicMethod entity:kPublicityNewsEntityName WithId:button.theId];
        [dic setObject:[entity titleBody] forKey:@"theme"];
        [dic setObject:commentBody forKey:@"content"];
        commentWriteRequestData=[[NSDictionary alloc]initWithDictionary:dic];
        
        
        
        [NetworkCenter AFRequestWithData:commentWriteRequestData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"result"] isEqualToString:@"success"]){
                [Alert showAlert:@"评论成功"];
            }
            else {
                [Alert showAlert:@"评论失败"];
            }
            
            //弹出提示：评论成功
            //            NSLog(@"评论成功");
            [co closeCommentView];
            
        } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {

        }];
        
        
    }];
}


@end
