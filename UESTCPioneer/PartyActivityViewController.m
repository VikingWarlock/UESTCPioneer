//
//  PartyActivityViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "PartyActivityViewController.h"
#import "UPTableView.h"
#import "UPTitleCell.h"
#import "UPMainInfoCell.h"
#import "UPFooterCell.h"
#import "LeveyTabBarController.h"

@interface PartyActivityViewController ()<UPFooterCellDelegate>

@end

@implementation PartyActivityViewController

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
//    label.text=@"组织活动";
//    label.center=self.view.center;
    UnreadKey=kUnreadPartyNoticeKey;

    
//    [self.view addSubview:label];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [dropbtn setTitle:@"最新" forState:UIControlStateNormal];
    
    
    #pragma mark 请求数据
    entityName=kPartyActivityNewsEntityName;
    entityMapping=[Mapping PartyActivityMapping];
    /*
     type=getEvent&userId=00100131103&page=1
     */
    requestData=@{@"type":@"getEvent",@"userId":[constant getUserId],@"page":@"1"};
    
    
    /*
     type=getEventComment&
     eventid:活动id序号；page：页码
     */
    commentListRequestData=@{@"type":@"getEventComment",@"eventid":@"0"
                             ,@"page":@"1"};
    commentIdKey=@"eventid";
    
    
    /*
     
ype：请求类型；userId：请求者权限Id；userName：请求者用户名；eventid：活动id（数据库中的序号）；comment：评论的内容（utf-8编码）
     */
    commentWriteRequestData=@{@"type":@"eventComment"
                              ,@"userId":[constant getUserId]
                              ,@"userName":[constant getUserName]
                              ,@"eventid":@"0"
                              ,@"comment":@""};
    commentWriteIdKey=@"eventid";
    commentContentKey=@"comment";
    
    commentListKeyMapping=@{@"commentAuthor":@"userName",@"commentContent":@"commentBody"};
    
}

-(void)viewWillAppear:(BOOL)animated{
            [self.leveyTabBarController.navigationItem setTitle:@"组织活动"];
}

- (void)dropClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"最新", @"热门",nil];
    if(dropDown == nil) {
        CGFloat f = 60;
        dropDown = [[NIDropDown alloc]initDropDown:sender :&f :arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

#pragma mark - dropDelegate

-(void)niDropDownDelegateMethod:(NIDropDown *)sender ForTitle:(NSString *)title ForIndex:(NSInteger)index{
        requestData=[RequestData ActivityDataWithTypeName:title];
        [self.tableView beginRefreshing];
    
    [self rel];
}

#pragma mark - TableView Delegate
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
    PartyActivityNewsEntity *entity = tableViewEntitiesArray[indexPath.section];
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
        UPTitleCell *cell1 = (UPTitleCell*)cell;
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
                UPFooterCell *cell3 = (UPFooterCell*)cell;
//        static NSString *customFooterCellIndentifier = @"CustomFooterCellIndentifier";
//        UPFooterCell *cell3 = [tableView dequeueReusableCellWithIdentifier:customFooterCellIndentifier];;
//        if(cell3 == nil){
//            cell3 = [[UPFooterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customFooterCellIndentifier];
//        }
//        UIButton *btn1 = (UIButton *)[cell3.contentView viewWithTag:btn1Tag];
//        UIButton *btn2 = (UIButton *)[cell3.contentView viewWithTag:btn2Tag];
//        UIButton *btn3 = (UIButton *)[cell3.contentView viewWithTag:btn3Tag];
//        btn1.hidden = NO;
        cell3.delegate=self;
        cell3.shareButtonEnable=YES;
        cell3.markButtonEnable=YES;
        
        [cell3.markButton setImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
        [cell3.markButton setImage:[UIImage imageNamed:@"sign_mark"] forState:UIControlStateSelected];
        
        
        [cell3 setShareButtonImage:[UIImage imageNamed:@"dig.png"]];
        [cell3 setShareNum:[entity.count integerValue]];
        
        
        BOOL signUp= [entity.signUp boolValue];
        [cell3 setMarkButtonStatus:signUp];
//        btn2.hidden = NO;
//        [btn1 setImage:[UIImage imageNamed:@"sign.png"] forState:UIControlStateNormal];
//        UIImageView *dig = (UIImageView *)[btn2 viewWithTag:11];
//        [dig setImage:[UIImage imageNamed:@"dig.png"]];
//        [btn2 setTitle:@"21" forState:UIControlStateNormal];


        return cell3;
    }
    
}

//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
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

#pragma mark - 点赞

/*
 type=clickLove&userId=00100131103&userName=1111&eventid=2
 */


-(void)UPFooterCell:(UPFooterCell *)cell shareButtonPress:(UIButton *)button{
    if (cell.shareButtonRequesting){
        [Alert showAlert:@"您点太快了"];
        return;
    }
    
    //@标识赞正在进行异步请求,防止用户快速点击
    cell.shareButtonRequesting=YES;
    
    PartyActivityNewsEntity *entity  =[PublicMethod entity:kPartyActivityNewsEntityName WithId:cell.theId];
    NSDictionary *DiggRequestData = @{
                                      @"type":@"clickLove"
                                      ,@"userId":[constant getUserId]
                                      ,@"userName":[constant getUserName]
                                      ,@"eventId":[NSString stringWithFormat:@"%d",cell.theId]
                                      };
    
    [NetworkCenter AFRequestWithData:DiggRequestData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *result =dic[@"result"];
        if ([result isEqualToString:@"successFavor"]){
            NSInteger count =  [entity.count integerValue];
            entity.count=[NSNumber numberWithInteger:++count];
            [cell setShareNum:count];
            [Alert showAlert:@"点赞成功"];
        }
        else if ([result isEqualToString:@"successCancel"]){
            NSInteger count =  [entity.count integerValue];
            entity.count=[NSNumber numberWithInteger:--count];
            [cell setShareNum:count];
            [Alert showAlert:@"取消赞"];
        }
        else [Alert showAlert:@"点赞错误"];
        cell.shareButtonRequesting=NO;
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"点赞错误"];
                cell.shareButtonRequesting=NO;
    }];
}

#pragma mark - 报名


/*
    type=getEvent&userId=00120051300
    
 type：请求类型；userId：用户权限Id；userName：用户名；eventid：要报名的活动序号；signUp：报名请求标志，1为报名，0为取消报名；name：用户的姓名（utf-8编码）
 */

-(void)UPFooterCell:(UPFooterCell *)cell markButtonClick:(UIButton *)button{
    
    
//    PartyActivityNewsEntity *entity = [PublicMethod entity:kPartyActivityNewsEntityName WithId:cell.theId];
    
    NSInteger signUp = button.selected;
    
    NSDictionary *signUpRequestData = @{
                                        @"type":@"getEvent"
                                        ,@"userId":[constant getUserId]
                                        ,@"userName":[constant getUserName]
                                        ,@"eventid":[NSString stringWithFormat:@"%d",cell.theId]
                                        ,@"signUp":[NSString stringWithFormat:@"%d",signUp]
                                        ,@"name":[constant getName]
                                        };
    
    
    [NetworkCenter AFRequestWithData:signUpRequestData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *resultString=dic[@"result"];
        resultString=[resultString substringToIndex:7];
        if ([resultString isEqualToString:@"success"]){
            [Alert showAlert:@"操作成功"];
        }
        else {
        [Alert showAlert:@"操作失败"];
        }

        
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"发生错误"];
    }];
    
}




//）type：getEvent  （2）userId：查看着的用户账号
//（3）page：页码
//
//#define testData @{@"type":@"getEvent",@"userId":@"0010013110361",@"page",@"1"}
//#define



@end
