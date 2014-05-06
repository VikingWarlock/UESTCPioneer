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
#import "StartActivity.h"


//#define MoodShareMapping @{@"commentNum":@"numberOfComment"\
//                            ,@"content":@"newsBody"\
//                            ,@"id":@"theId"\
//                            ,@"picUrl":@"picUrl"\
//                            ,@"time":@"timeAndDate"\
//                            ,@"userId":@"userId"\
//                            ,@"userName":@"titleBody"\
//}

#define requestTestData @{@"type":@"getEventShare",@"userId":@"0010013110361",@"page":@"1"}

#define MoodShareEntityName @"MoodShareNewsEntity"


#define normalCommitButtonColor [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1]




#pragma mark - EditShareViewController
@interface EditShareViewController:StartActivity{
    UILabel *_titleLabel;
    UITextView *writeRect;
}

@property NSString *shareTitle;

@end
@implementation EditShareViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    isFirstEdit1=NO;
    
    
    //隐藏默认返回按钮
    [self.navigationItem setHidesBackButton:YES];
    //修改标题
        self.navigationItem.title=@"编辑分享";
    [self.view setBackgroundColor:ViewControllerBackgroundColor];
    
    
    //修改背景色为白色
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    //修改字体为红色
    [self.navigationController.navigationBar setTintColor:kNavigationBarColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigationBarColor}];
    
    //修改顶部运营商和时间为黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //修改左边button
    UIBarButtonItem *leftBarButton  =[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pop:)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    //    [leftBarButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    
    UIBarButtonItem *rightBarButton  = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(commitShare:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    [rightBarButton setTitleTextAttributes:@{NSForegroundColorAttributeName:normalCommitButtonColor} forState:UIControlStateNormal];
    

    
    self.editTitle.editable=NO;
    self.editTitle.text=_shareTitle;
    [self.editTitle setTextColor:[UIColor blackColor]];
    
//#pragma mark 标题栏
//    _titleLabel=[[UILabel alloc]init];
//    [self.view addSubview:_titleLabel];
//    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_titleLabel(==30)]" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_titleLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
//    _titleLabel.text=@"  支部生活有你我";
//    [_titleLabel.layer setBorderColor:kBorderColor.CGColor];
//    [_titleLabel.layer setBorderWidth:1];
//    [_titleLabel.layer setCornerRadius:4];
//    [_titleLabel setBackgroundColor:[UIColor whiteColor]];
//    
//#pragma mark 书写栏
//    writeRect = [[UITextView alloc]init];
//    [self.view addSubview:writeRect];
//    [writeRect setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [writeRect.layer setBorderColor:kBorderColor.CGColor];
//    [writeRect.layer setBorderWidth:1];
//    [writeRect.layer setCornerRadius:4];
//    [writeRect setBackgroundColor:[UIColor whiteColor]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-10-[writeRect(==160)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel,writeRect)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[writeRect]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(writeRect)]];
//    [writeRect setFont:[UIFont systemFontOfSize:18]];
    

    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
            self.navigationItem.title=@"编辑分享";
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //还原顶部设置
        [self.navigationController.navigationBar setBarTintColor:kNavigationBarColor];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationItem setHidesBackButton:NO];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//-(void)viewDidDisappear:(BOOL)animated{
//    [[UINavigationBar appearance]setBarTintColor:kNavigationBarColor];
//    [self.navigationController.navigationBar setBarTintColor:];
}

#pragma mark - pop button
-(void)pop:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - commit share 


-(void)commit:(id)sender{
    NSDictionary *requestD = @{@"userId":[constant getUserId]
                               ,@"eventTitle":[helper urlencode:self.editTitle.text]
                               ,@"userName":[constant getUserName]
                               ,@"content":[helper urlencode:self.editBody.text]
                               ,@"type":@"EventShare"
                               };
    
    

    [NetworkCenter requestActivity:requestD ImageArray:[self getPickedImageArray] SuccessBlock:^(id resultObject) {
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:Nil];
        if ([dic[@"result"] isEqualToString:@"success"]){
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            [helper performBlock:^{
                MoodShareViewController *m= (MoodShareViewController*)self.leveyTabBarController.selectedViewController;
                [m.tableView beginRefreshing];
            } afterDelay:0.45];
            

            
        }
        else {
            [Alert showAlert:@"发生错误"];
        }
    } failure:^(NSError *error) {
        
    }];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [writeRect resignFirstResponder];
}

@end


#pragma mark - SelectTableView
@interface SelectTableView :UITableView
@end

@implementation SelectTableView

//-(void)setFrame:(CGRect)frame{
//    frame.origin.y+=10;
//    frame.origin.x+=16;
//    frame.size.width-=32;
//}
@end





#pragma mark - SelectShareViewCotroller

@interface SelectShareViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITextField *searchField;
    SelectTableView *_tableView;
    NSLayoutConstraint *tableViewHeightConstraint;
    NSArray *titleArrayForDataSoruce;
}

@end

@implementation SelectShareViewController

-(void)viewDidLoad{
    [self.view setBackgroundColor:ViewControllerBackgroundColor];
    
#pragma mark 顶部搜索栏
    //背景
    UIView *topRect = [[UIView alloc]init];
    [self.view addSubview:topRect];
    [topRect setBackgroundColor:[UIColor whiteColor]];
    [topRect setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-1)-[topRect]-(-1)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topRect)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-1)-[topRect(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topRect)]];
    [topRect.layer setBorderColor:kBorderColor.CGColor];
    [topRect.layer setBorderWidth:1];
    //搜索栏
    searchField = [[UITextField alloc]init];
    
    
    //搜索栏改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTextChangeNotification:) name:UITextFieldTextDidChangeNotification object:searchField];
    
    [topRect addSubview:searchField];
    [searchField.layer setBorderWidth:1];
    [searchField.layer setBorderColor:kBorderColor.CGColor];
    [searchField setBackgroundColor:ViewControllerBackgroundColor];
    [searchField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [topRect addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[searchField]-16-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(searchField)]];
    [topRect addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[searchField]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(searchField)]];
    [searchField setPlaceholder:@"请选择一个活动"];
    
#pragma mark TableView
    _tableView=[[SelectTableView alloc]init];
    [self.view addSubview:_tableView];
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_tableView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topRect]-8-[_tableView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView,topRect)]];
    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-40]];
    
    tableViewHeightConstraint=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self.view addConstraint:tableViewHeightConstraint];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [_tableView.layer setBorderColor:kBorderColor.CGColor];
    [_tableView.layer setBorderWidth:1];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
  
    [self doSearchTitle:@""];
}





-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title=@"选择活动";
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [searchField resignFirstResponder];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row=[titleArrayForDataSoruce count];
    if (row>10)tableViewHeightConstraint.constant=44*10;
    else tableViewHeightConstraint.constant=row*44;
    return row;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text=titleArrayForDataSoruce[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditShareViewController *editShare = [[EditShareViewController alloc]initWithStyle:UITableViewStyleGrouped];
    editShare.shareTitle=titleArrayForDataSoruce[indexPath.row];
//    [self.navigationController presentViewController:editShare animated:YES completion:NULL];
    [self.navigationController pushViewController:editShare animated:YES];
    [searchField resignFirstResponder];
}

#pragma mark - do search title
//发请求，通过关键字请求活动标题列表
-(void)doSearchTitle:(NSString*)title{
    //222.197.183.81:8080/UestcApp/ieaction.do?type=searchTitle&userId=0012005130022&title=
    
    NSDictionary *RequestD = @{@"type":@"searchTitle"
                               ,@"userId":[constant getUserId]
                               ,@"title":title};
    
    [NetworkCenter AFRequestWithData:RequestD SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *mut = [[NSMutableArray alloc] init];
        for (NSDictionary *dicItem in dic){
            [mut addObject:dicItem[@"title"]];
        }
        
        titleArrayForDataSoruce=[[NSArray alloc]initWithArray:mut];
        [_tableView reloadData];
        
        
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - searchText Change Notification
-(void)searchTextChangeNotification:(NSNotification*)notify{
    UITextField *textField = [notify object];
    [self doSearchTitle:textField.text];
}

@end

#pragma mark - MoodShareViewController


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
        tableViewTopConstraint.constant=0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    


//    [self.tableView setPullDownBeginRefreshAction:@selector(refreshRequest:) ];
    
    
    
#pragma mark request Data load
    entityName=kMoodShareNewsEntityName;
    entityMapping=[Mapping MoodShareMapping];
    requestData=@{@"type":@"getEventShare",@"userId":[constant getUserId],@"page":@"1"};
    //请求评论列表用的参数
    commentListRequestData=@{@"type":@"getShareComment",@"page":@"1",@"shareId":@"0"};
    //写评论请求用的参数
    commentWriteRequestData=@{@"type":@"writeShareComment",@"userId":[constant getUserId],@"userName":[constant getUserName],@"shareId":@"0",@"comment":@""};
    commentIdKey=@"shareId";
    commentContentKey=@"comment";
    commentWriteIdKey=commentIdKey;
    commentListKeyMapping=@{@"commentAuthor":@"userName",@"commentContent":@"commentBody"};
    
}

-(void)viewDidAppear:(BOOL)animated{

}





-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leveyTabBarController.navigationItem setTitle:@"活动分享"];
    
    UIButton *writeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [writeButton setImage:[UIImage imageNamed:@"write"] forState:UIControlStateNormal];
    [writeButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 5, 5)];
    [writeButton addTarget:self action:@selector(writeButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[helper BarButtonItemWithUIButton:writeButton ButtonOrigin:CGPointMake(10, 0)];
    [self.leveyTabBarController.navigationItem setRightBarButtonItem:barButton];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.leveyTabBarController.navigationItem setRightBarButtonItem:nil];
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
//        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_head_image.png"]];
//        img.frame = CGRectMake(5, 5, 45, 45);
//        [cell.contentView addSubview:img];
//        UILabel *title = (UILabel *)[cell.contentView viewWithTag:titleTag];
//        title.frame = CGRectMake(60, 10, 250, 20);
//        title.text = DataEntity.titleBody;
//        UILabel *time = (UILabel *)[cell.contentView viewWithTag:timeTag];
//        time.frame = CGRectMake(60, 30, 250, 20);
//        time.text = [DataEntity.timeAndDate description];
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
//        words.text=DataEntity.newsBody;
//        return cell2;
        UPMainInfoCell *cell2= (UPMainInfoCell*)cell;
        
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
//        
//        commentButton *btn3 = (commentButton *)[cell3.contentView viewWithTag:btn3Tag];
//        [btn3 setTitle:[NSString stringWithFormat:@"%d",[DataEntity.numberOfComment integerValue]] forState:UIControlStateNormal];
//        btn3.theId=[DataEntity.theId integerValue];
//        
//        [btn3 addTarget:self action:@selector(commentButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        UPFooterCell *cell3 = (UPFooterCell*)cell;
//        UIButton *btn1 = (UIButton *)[cell3.contentView viewWithTag:btn1Tag];
//        UIButton *btn2 = (UIButton *)[cell3.contentView viewWithTag:btn2Tag];
        
//        btn1.hidden = NO;
//        btn2.hidden = NO;
        

        [cell3 addCommentButtonTaget:self Action:@selector(commentButtonPress:)];
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

#pragma mark -  pull Refresh
//在父类实现


//-(void)pullDownRefresh:(MJRefreshBaseView *)refreshView{
//    [NetworkCenter RKRequestWithData:requestTestData EntityName:MoodShareEntityName Mapping:MoodShareMapping SuccessBlock:^(NSArray *resultArray) {
//        tableViewEntitiesArray=resultArray;
//        [self.tableView reloadData];
//        [PublicMethod ClearAllCoreData];
//        [refreshView endRefreshing];
//
//        
//    } failure:^(NSError *error) {
//        NSLog(@"error:%@",error);
//        [refreshView endRefreshing];
//    }];
//}
//
//-(void)pullUpRefresh:(MJRefreshBaseView *)refreshView{
//    
//    NSMutableDictionary *tempDic= [[NSMutableDictionary alloc]initWithDictionary:requestTestData];
//    [tempDic setObject:@(PullUpRefreshTimes+2) forKey:@"page"];
//    
//    [NetworkCenter RKRequestWithData:tempDic EntityName:MoodShareEntityName Mapping:MoodShareMapping SuccessBlock:^(NSArray *resultArray) {
//        
//        
//        NSMutableArray *newArray = [[NSMutableArray alloc]initWithArray:tableViewEntitiesArray];
//        [newArray addObjectsFromArray:resultArray];
//        NSArray *result = [[NSArray alloc]initWithArray:newArray];
//        
//        
//        tableViewEntitiesArray=result;
//        [self.tableView reloadData];
//        [PublicMethod ClearAllCoreData];
//        [refreshView endRefreshing];
//        PullUpRefreshTimes++;
//        
//    } failure:^(NSError *error) {
//        NSLog(@"error:%@",error);
//        [refreshView endRefreshing];
//    }];
//}



#pragma mark - commentButton press

//-(void)commentButtonPress:(commentButton*)button{
//    commentViewController *comment = [[commentViewController alloc]init];
//    
//    
////    1）type：writeShareComment  （2）user_id：用户的账号
////    （3）username：用户姓名      （4）shareId：活动分享的id
////    （5）comment：评论的内容
//
//    
//    //请求评论列表用的参数
//    comment.commentListRequestData=@{@"type":@"getShareComment",@"page":@"1",@"shareId":[NSString stringWithFormat:@"%d",button.theId]};
//    
//    
//    //写评论请求用的参数
//    comment.commentRequestData=@{@"type":@"writeShareComment",@"user_id":[constant getUserId],@"username":[constant getUserName],@"shareId":[NSString stringWithFormat:@"%d",button.theId],@"comment":@""};
//    
////    comment.theId=button.theId;
//    comment.numberOfComment=[button.titleLabel.text integerValue];
//    [self.leveyTabBarController.navigationController pushViewController:comment animated:YES];
//}


#pragma mark - writeButtonPress
-(void)writeButtonPress:(UIButton*)button{
    SelectShareViewController *edit = [[SelectShareViewController alloc]init];
    [self.leveyTabBarController.navigationController pushViewController:edit animated:YES];
}



@end
