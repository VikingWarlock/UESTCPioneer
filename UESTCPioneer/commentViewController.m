//
//  commentViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-22.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "commentViewController.h"
#import"commentView.h"
#define backgroundColor [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1]


#pragma mark - commentTableViewCell

@interface commentTableViewCell : UITableViewCell
@property  UIImageView *headImageView;
@property  UILabel *userName;
@property UILabel *commentBody;

@end

@implementation commentTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setBackgroundColor:backgroundColor];
        [self.contentView setBackgroundColor:backgroundColor];
        self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 2, 2)];
        self.userName=[[UILabel alloc]initWithFrame:CGRectMake(44, 10, 100, 22)];
        self.commentBody=[[UILabel alloc]initWithFrame:CGRectMake(10, 44, 280, 60)];
        [self.commentBody setNumberOfLines:3];
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.userName];
        
        [self.contentView addSubview:self.commentBody];
        [self.headImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.userName setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.commentBody setTranslatesAutoresizingMaskIntoConstraints:NO];

        

        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_headImageView(==22)]-[_userName]-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_headImageView,_userName)]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_headImageView(==22)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_headImageView)]];
        
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_userName(==22)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_userName)]];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_commentBody]-|" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(_commentBody)]];
        
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_userName]-[_commentBody]-|" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(_commentBody,_userName)]];
        
        
        

        
        


    }
    return self;
}

@end


#pragma mark - commentTableView

@interface commentTableView : UPTableView


@end

@implementation commentTableView



@end



@interface commentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
//    commentTableView *TableView;
    NSArray *tableViewDataArray;
}

@end


#pragma mark - commentViewController

static NSString *cellIdentifier=@"cell";

@implementation commentViewController
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
    [self.view setBackgroundColor:backgroundColor];
    
    [self.tableView setBackgroundColor:backgroundColor];
//    TableView=[[commentTableView alloc]initWithFrame:self.view.bounds];
    [self.tableView registerClass:[commentTableViewCell class] forCellReuseIdentifier:cellIdentifier];
//    [self.view addSubview:TableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    

    
    
#pragma mark 加导航栏按钮
    //    UIView *customView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [customView addSubview:commentButton];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(4, 4, 30, 22)];
    [imageView setImage:[UIImage imageNamed:@"com.png"]];
    [commentButton addSubview:imageView];
    
    //    [commentButton setFrame:customView.bounds];
    [commentButton setTitle:[NSString stringWithFormat:@"%d",self.numberOfComment] forState:UIControlStateNormal];
    [commentButton addTarget:self action:@selector(commentButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 22, 0, 0)];
    UIBarButtonItem *rightCommentBarButton=[helper BarButtonItemWithUIButton:commentButton ButtonOrigin:CGPointMake(20, 0) CustomViewSize:CGSizeMake(88, 44)];
    NSLog(@"%@",self.navigationController.navigationItem.leftBarButtonItems);
    
    [self.navigationItem setRightBarButtonItem:rightCommentBarButton];

    
 
    
    [self.tableView beginRefreshing];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)_requestList{
    


}

#pragma mark - tableview Delegate and DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [tableViewDataArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    commentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.headImageView setImageWithURL:tableViewDataArray[indexPath.row][@"headImageUrl"] placeholderImage:[UIImage imageNamed:@"touxiang.png"]];
    
    cell.userName.text=tableViewDataArray[indexPath.row][@"userName"];
    cell.commentBody.text=tableViewDataArray[indexPath.row][@"commentBody"];
    return cell;
}

#pragma mark - commentButton press

-(void)commentButtonPress:(UIButton*)button{
    
   __weak commentViewController *weakSelf=self;
    
    commentView *co=[[commentView alloc]init];
    
    [co popUpCommentViewWithCommitBlock:^(NSString *commentBody) {
        NSMutableDictionary *dic= [[NSMutableDictionary alloc]initWithDictionary:weakSelf.commentRequestData];
//        [weakSelf.commentRequestData setObject:@"comment" forKey:commentBody];
        dic[@"comment"]=commentBody;
        self.commentRequestData=[[NSDictionary alloc]initWithDictionary:dic];
        [NetworkCenter AFRequestWithData:self.commentRequestData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {

            //弹出提示：评论成功
            NSLog(@"评论成功");
            [co closeCommentView];
            [self _requestList];
            
        } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            //弹出提示：评论失败
            NSLog(@"评论失败");
        }];
    }];

}

-(void)pullUpRefresh:(MJRefreshBaseView *)refreshView{
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]initWithDictionary:self.commentListRequestData];
    [tempDic setObject:[NSString stringWithFormat:@"%d",PullUpRefreshTimes+2] forKey:@"page"];
    
//    self.commentListRequestData = [[NSDictionary alloc]initWithDictionary:tempDic];
    
    
    [NetworkCenter AFRequestWithData:tempDic SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        
        
        
        NSError *error;
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:&error];
        //如果空
        if ([arr count]==0){
            [refreshView endRefreshing];
            return ;
        }
        
        
        
        NSMutableArray *targetArray = [[NSMutableArray alloc]init];
        for (NSDictionary *sourceDic in arr){
            
            NSMutableDictionary *targetDic = [[NSMutableDictionary alloc]init];
            [targetDic setObject:@"" forKey:@"headImageUrl"];
            [targetDic setObject:sourceDic[@"userName"] forKey:@"userName"];
            [targetDic setObject:sourceDic[@"comment"] forKey:@"commentBody"];
            [targetArray addObject:targetDic];
        }
        
        NSMutableArray *muArr = [[NSMutableArray alloc]initWithArray:tableViewDataArray];
        [muArr addObjectsFromArray:targetArray];
        tableViewDataArray = [[NSArray alloc]initWithArray:muArr];
//        tableViewDataArray=targetArray;
        [refreshView endRefreshing];
        [self.tableView reloadData];
        PullUpRefreshTimes++;
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"commentViewController init request error:%@",error);
    }];
}
-(void)pullDownRefresh:(MJRefreshBaseView *)refreshView{
    [NetworkCenter AFRequestWithData:self.commentListRequestData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        
        NSError *error;
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:&error];
        
        
        NSMutableArray *targetArray = [[NSMutableArray alloc]init];
        for (NSDictionary *sourceDic in arr){
            
            NSMutableDictionary *targetDic = [[NSMutableDictionary alloc]init];
            [targetDic setObject:@"" forKey:@"headImageUrl"];
            [targetDic setObject:sourceDic[@"userName"] forKey:@"userName"];
            [targetDic setObject:sourceDic[@"comment"] forKey:@"commentBody"];
            [targetArray addObject:targetDic];
        }
        tableViewDataArray=targetArray;
        [refreshView endRefreshing];
        [self.tableView reloadData];
        
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"commentViewController init request error:%@",error);
    }];
}

@end

