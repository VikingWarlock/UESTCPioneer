//
//  PartyNoticeViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "PartyNoticeViewController.h"
#import "UPTableView.h"
#import "UPTitleCell.h"
#import "UPMainInfoCell.h"
#import "UPFooterCell.h"
#import "LeveyTabBarController.h"
#import "shareEditView.h"

@interface PartyNoticeViewController ()<UPFooterCellDelegate,UPTitleCellDelegate>

@end

@implementation PartyNoticeViewController

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
//    label.text=@"党委通知";
//    label.center=self.view.center;
    
    UnreadKey=kUnreadPartyNoticeKey;
    
//    [self.view addSubview:label];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        [dropbtn setTitle:@"支部" forState:UIControlStateNormal];
    
    //链接请求参数
    
    /*
     
     type=getNoticeOrAnnounce&userId=0004003990022&userName=xiao002&page=1&typepid=1&level=2
     */
    requestData=@{@"type":@"getNoticeOrAnnounce"
                  ,@"userId":[constant getUserId]
                  ,@"userName":[constant getUserName]
                  ,@"page":@"1"
                  ,@"typepid":@"1"
                  ,@"level":@"2"};
    entityName=kPartyNoticeNewsEntityName;
    entityMapping=[Mapping PartyNoticeMapping];
    
    
    /*
     type=getNAcomment&noticeid=13&userId=0012005130022&typepid=1&page=1
     
     */
    commentIdKey=@"noticeid";
    commentListRequestData=@{@"type":@"getNAcomment"
                             ,@"noticeid":@"0"
                             ,@"userId":[constant getUserId]
                             ,@"typepid":@"1"
                             ,@"page":@"1"};
    
    
    /*
     type=writeNAcomment&fromusername=xiao002&fromuserid=0004003990022&gonggaoid=1&content=通知的评论&typepid=1
     
     */
    commentWriteIdKey=@"gonggaoid";
    commentWriteRequestData=@{@"type":@"writeNAcomment"
                              ,@"fromusername":[constant getUserName]
                              ,@"fromuserid":[constant getUserId]
                              ,@"gonggaoid":@"0"
                              ,@"content":@""
                              ,@"typepid":@"1"};
    commentContentKey=@"content";
    commentListKeyMapping=@{@"commentContent":@"commentBody",@"commentAuthor":@"userName"};
    
    

}

-(void)viewWillAppear:(BOOL)animated{
        [self.leveyTabBarController.navigationItem setTitle:@"党委通知"];
}

- (void)dropClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"校级",@"院级",@"支部",@"全部",nil];
    if(dropDown == nil) {
        CGFloat f = 120;
        dropDown = [[NIDropDown alloc]initDropDown:sender :&f :arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

-(void)niDropDownDelegateMethod:(NIDropDown *)sender ForTitle:(NSString *)title ForIndex:(NSInteger)index{
    if ([title isEqualToString:@"校级"]){
        requestData=[RequestData NoticeDataWithLevel:0];
        [self.tableView beginRefreshing];
    }
    else if ([title isEqualToString:@"院级"]){
        requestData=[RequestData NoticeDataWithLevel:1];
        [self.tableView beginRefreshing];
    }
    else if ([title isEqualToString:@"支部"]){
        requestData=[RequestData NoticeDataWithLevel:2];
        [self.tableView beginRefreshing];
    }
    else if ([title isEqualToString:@"全部"]){
        requestData=[RequestData NoticeDataWithLevel:3];
        [self.tableView beginRefreshing];
    }
    [self rel];
}

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

//表的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [tableViewEntitiesArray count];
}

//- (void)collectTaped:(UIButton *)collect{
//    UITableViewCell *cell = (UITableViewCell *)[[[collect superview]superview]superview];
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    //收藏
//    [collect setImage:[UIImage imageNamed:@"collect_highlighted.png"] forState:UIControlStateNormal];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    PartyNoticeNewsEntity *entity = tableViewEntitiesArray[indexPath.section];
    
    
    if (indexPath.row == 0) {

        UPTitleCell *titleCell = (UPTitleCell*)cell;
        
        titleCell.delegate=self;
        [titleCell setCollectButtonEnable:YES];
        
        BOOL collected = [entity.shoucang boolValue];
        if (collected)[titleCell setCollectButtonStatus:YES];
        else [titleCell setCollectButtonStatus:NO];
        
//        UIButton *collect = (UIButton *)[titleCell.contentView viewWithTag:collectTag];
//        collect.hidden = NO;
//        [collect addTarget:self action:@selector(collectTaped:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if (indexPath.row == 1) {
        UPMainInfoCell*cell2=(UPMainInfoCell*)cell;

//        static NSString *customMainCellIndentifier = @"CustomMainCellIndentifier";
//        UPMainInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:customMainCellIndentifier];;
//        if(cell2 == nil){
//            cell2 = [[UPMainInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customMainCellIndentifier];
//        }
//        UILabel *words = (UILabel *)[cell2.contentView viewWithTag:wordsTag];
//        words.text = @"在讨论这部纪录片之前，为了避免现在中文网络江湖盛行的动机论，我先要说明：我和崔永元老师没有个人恩怨，相反，对他的主持功力和以前取得的成绩都非常钦佩。我们也至少有一名共同的好朋友，《读库》的出版人张立宪。";
        return cell2;
    }
    else {
        UPFooterCell*cell3=(UPFooterCell*)cell;
                        cell3.delegate=self;
//        static NSString *customFooterCellIndentifier = @"CustomFooterCellIndentifier";
//        UPFooterCell *cell3 = [tableView dequeueReusableCellWithIdentifier:customFooterCellIndentifier];;
//        if(cell3 == nil){
//            cell3 = [[UPFooterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customFooterCellIndentifier];
//        }
//        UIButton *btn1 = (UIButton *)[cell3.contentView viewWithTag:btn1Tag];
//        UIButton *btn2 = (UIButton *)[cell3.contentView viewWithTag:btn2Tag];
//        UIButton *btn3 = (UIButton *)[cell3.contentView viewWithTag:btn3Tag];
//        btn1.hidden = NO;
//        btn2.hidden = NO;
//        
//        [btn1 setImage:[UIImage imageNamed:@"read.png"] forState:UIControlStateNormal];
        

        [cell3 setShareButtonEnable:YES];        
        [cell3 setShareNum:[entity.transnum integerValue]];
        UIButton *btn1 = (UIButton *)[cell3.contentView viewWithTag:btn1Tag];
//        UIButton *btn2 = (UIButton *)[cell3.contentView viewWithTag:btn2Tag];

        btn1.hidden = NO;
//        btn2.hidden = NO;

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
#pragma mark - UPFooterCellDelegate

-(void)shareButtonClick:(NSInteger)theId{
    shareEditView *shareView = [[shareEditView alloc]init];
    
    PartyNoticeNewsEntity *entity=[PublicMethod entity:kPartyNoticeNewsEntityName WithId:theId];
    
    [shareView popUpCommentViewWithShareSourceInfo:entity.newsBody CommitBlock:^(NSString *commentBody) {
        /*
             type=transmitNotice&naid=13&userId=0012005130022&userName=xiaopangzi&content=13&type
         
            //注意，转发只有管理员可以，管理员id末位为1或者2
         */
        
        

        //@评论内容要加上@对方用户的信息
        commentBody=[commentBody stringByAppendingString:[NSString stringWithFormat:@"@%@//",entity.userName]];
        
        //@判断是否为管理员
        NSString *userId=[constant getUserId];
        NSLog(@"%d",userId.length);
        NSString *lastChar =[userId substringFromIndex:[userId length]-1];
        
        if (!([lastChar isEqualToString:@"1"] || [lastChar isEqualToString:@"2"])){
            //判断为非管理员
            [Alert showAlert:@"对不起，你不是管理员!"];
            [shareView closeCommentView];
        }
        
        
        NSDictionary *ShareRequestData = @{@"type":@"transmitNotice"
                                      ,@"naid":[NSString stringWithFormat:@"%d",theId]
                                      ,@"content":commentBody
                                      ,@"userId":userId
                                      ,@"userName":[constant getUserName]
                                      ,@"typepid":@"1"
                                      };
        
        
        
        [NetworkCenter AFRequestWithData:ShareRequestData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"result"] isEqualToString:@"success"]){
                [Alert showAlert:@"转发成功"];
                [shareView closeCommentView];
                [self.tableView beginRefreshing];
            }
            else {
                [Alert showAlert:@"转发失败"];
            }
        } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Alert showAlert:@"转发错误"];
        }];
        
        
    }];
    
}
#pragma mark - UPTitleCell Delegate 

/*
    type=naViewcollect&view_collect=0&shoucang=1&fromusername=xiaopangzi&fromuserid=00120
 
 */

-(void)UPTitleCell:(UPTitleCell *)cell CollectButtonClick:(UIButton *)button{
    
    if (cell.collecting){
        [Alert showAlert:@"点太快了"];
        return;
    }
    
    NSInteger flag = button.selected;
    
    NSDictionary *CollectReqeustData = @{
                                         @"type":@"naViewcollect"
                                         ,@"view_collect":@"0"
                                         ,@"shoucang":[NSString stringWithFormat:@"%d",flag]
                                         ,@"fromusername":[constant getUserName]
                                         ,@"fromuserid":[constant getUserId]
                                         };
    
    //异步锁
    cell.collecting=YES;
    
#warning 这边服务器内部错误,正在协商
    [NetworkCenter AFRequestWithData:CollectReqeustData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:Nil];
        if ([dic[@"result"] isEqualToString:@"success"]){
            [Alert showAlert:@"成功！"];
        }
        else {
            [Alert showAlert:@"失败!"];
        }
        cell.collecting=NO;
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"发生错误"];
        cell.collecting=NO;
    }];
    
    if (button.selected){
        NSLog(@"已赞");
    }
    else {
        NSLog(@"取消赞");
    }
}

@end
