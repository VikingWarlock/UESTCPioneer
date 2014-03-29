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
    
    
    //请求初始化
    entityName=kPioneerEntityName;
    entityMapping=[Mapping PioneerMapping];
    requestData=@{@"type":@"getNews",@"page":@"1"};
    //请求评论列表用的参数
    commentListRequestData=@{@"type":@"getNewsComments",@"page":@"1",@"id":@"0"};
    //写评论请求用的参数
    commentWriteIdKey=@"id";
    commentWriteRequestData=@{@"type":@"setNewsComment",@"userName":[constant getUserName],@"id":@"0",@"comments":@""};
    commentIdKey=@"id";
    commentContentKey=@"comments";
    
    
    commentListKeyMapping=@{@"commentAuthor":@"userName",@"commentContent":@"commentBody"};
    
    
    
    
//    NSLog(@"self.view=%f",self.view.bounds.size.height);
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



-(void)niDropDownDelegateMethod:(NIDropDown *)sender ForTitle:(NSString *)title ForIndex:(NSInteger)index{
    if ([title isEqualToString:@"全部"]){
        requestData=[RequestData AllNewsReqeustData];
        [self.tableView beginRefreshing];
    }
    else if ([title isEqualToString:@"通信"]){
        requestData=[RequestData CollegeRequestDataWithCode:@"001"];
        [self.tableView beginRefreshing];
    }
    else if ([title isEqualToString:@"计算机"]){
        requestData=[RequestData CollegeRequestDataWithCode:@"006"];
        [self.tableView beginRefreshing];
    }
    else if ([title isEqualToString:@"微固"]){
        requestData=[RequestData CollegeRequestDataWithCode:@"003"];
        [self.tableView beginRefreshing];
    }
    else if ([title isEqualToString:@"数学"]){
        requestData=[RequestData CollegeRequestDataWithCode:@"010"];
        [self.tableView beginRefreshing];
    }
    else if ([title isEqualToString:@"外国语"]){
        requestData=[RequestData CollegeRequestDataWithCode:@"013"];
        [self.tableView beginRefreshing];
    }
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
    UITableViewCell*cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
//    PioneerNewsEntity *entity = tableViewEntitiesArray[indexPath.section];

    
    if (indexPath.row == 0) {
//    static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
//    UPTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier];
//    if(cell == nil){
//        cell = [[UPTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTitleCellIndentifier];
//    }
//    UILabel *title = (UILabel *)[cell.contentView viewWithTag:titleTag];
////        NSString *t=entity.titleBody;
//        title.text = entity.titleBody;
//    UILabel *time = (UILabel *)[cell.contentView viewWithTag:timeTag];
//        time.text = [entity.timeAndDate description];
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
////        words.text = @"在讨论这部纪录片之前，为了避免现在中文网络江湖盛行的动机论，我先要说明：我和崔永元老师没有个人恩怨，相反，对他的主持功力和以前取得的成绩都非常钦佩。我们也至少有一名共同的好朋友，《读库》的出版人张立宪。";
//        words.text=entity.newsBody;
                UPMainInfoCell*cell2=(UPMainInfoCell*)cell;
        return cell2;
    }
    else {
//        static NSString *customFooterCellIndentifier = @"CustomFooterCellIndentifier";
//        UPFooterCell *cell3 = [tableView dequeueReusableCellWithIdentifier:customFooterCellIndentifier];;
//        if(cell3 == nil){
//            cell3 = [[UPFooterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customFooterCellIndentifier];
//        }
//        
//        
//        commentButton *btn3 = (commentButton *)[cell3.contentView viewWithTag:btn3Tag];
//        [btn3 setTitle:[entity.numberOfComment stringValue] forState:UIControlStateNormal];
        UPFooterCell*cell3=(UPFooterCell*)cell;
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


@end
