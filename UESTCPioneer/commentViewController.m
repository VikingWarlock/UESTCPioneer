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


//@ what the hell? 究竟怎么回事，为什么会多出35
-(void)setFrame:(CGRect)frame{
    frame.origin.y-=35;
    [super setFrame:frame];
}

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

        [self.userName setFont:[UIFont systemFontOfSize:13]];
        [self.userName setTextColor:[UIColor colorWithRed:69.0/255.0 green:120.0/255.0 blue:200.0/255.0 alpha:1]];

        
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_headImageView(==22)]-[_userName]-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_headImageView,_userName)]];

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_headImageView(==22)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_headImageView)]];
        
                [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_userName(==22)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_userName)]];
        
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_commentBody]-|" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(_commentBody)]];
        
                [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_userName]-[_commentBody]-|" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(_commentBody,_userName)]];
        
        
        

        
        


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
//    [self.navigationController.navigationBar setTranslucent:YES];
    [self.view setBackgroundColor:backgroundColor];
//    [self.tableView removeFromSuperview];
//    self.tableView=[[UITableView alloc]init];
    
    
    
//    [self.view addSubview:self.tableView];
    [self.tableView setBackgroundColor:backgroundColor];
//    [self.view setBackgroundColor:[UIColor blueColor]];
//    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:YES];
//    [self.tableView setFrame:CGRectMake(0, 0, 320, 455)];
    

    tableViewTopConstraint.constant=0;
//    TableView=[[commentTableView alloc]initWithFrame:self.view.bounds];
    [self.tableView registerClass:[commentTableViewCell class] forCellReuseIdentifier:cellIdentifier];
//    [self.view addSubview:TableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;

    
//    NSLog(@"%f,%f,%f,%f",self.tableView.frame.origin.x,self.tableView.frame.origin.y,self.tableView.frame.size.width,self.tableView.frame.size.height);
    
    
//    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:YES];
//    CGRect re = self.tableView.frame;
//    re.origin.y=0;
//    [self.tableView setFrame:re];
//    NSLog(@"%f",self.tableView.frame.origin.y);

//    [self.tableView setFrame:<#(CGRect)#>]

    
    
//    [self.tableView setClipsToBounds:NO];
//    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.tableView removeConstraints:self.tableView.constraints];
//    __weak UITableView *table = self.tableView;
////    [self.tableView setBackgroundColor:[UIColor redColor]];
//    [table setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(table)]];
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(table)]];
    
    
//    tableViewTopConstraint.constant=0;
    
    
//    NSLog(@"%@",self.view.subviews);
//    NSLog(@"%@",self.view.constraints);
//    [self.tableView reloadData];
//    [self.view setNeedsLayout];
//    [self.tableView setContentInset:UIEdgeInsetsMake(-30, 0, 0, 0)];
    
#pragma mark 加导航栏按钮
    //    UIView *customView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [customView addSubview:commentButton];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
    [imageView setImage:[UIImage imageNamed:@"com.png"]];
    [commentButton addSubview:imageView];
    
    //    [commentButton setFrame:customView.bounds];
    [commentButton setTitle:[NSString stringWithFormat:@"%d",self.numberOfComment] forState:UIControlStateNormal];
    [commentButton addTarget:self action:@selector(commentButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 24, 24)];
    UIBarButtonItem *rightCommentBarButton=[helper BarButtonItemWithUIButton:commentButton ButtonOrigin:CGPointMake(46, 13) CustomViewSize:CGSizeMake(88, 44)];
    NSLog(@"%@",self.navigationController.navigationItem.leftBarButtonItems);
    
    [self.navigationItem setRightBarButtonItem:rightCommentBarButton];

    
 
    
//    [self.tableView beginRefreshing];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    [cell.headImageView setImageWithURL:tableViewDataArray[indexPath.row][@"headImageUrl"] placeholderImage:[UIImage imageNamed:@"defaultHeadImage.png"]];
    
    cell.userName.text=tableViewDataArray[indexPath.row][@"userName"];
    cell.commentBody.text=tableViewDataArray[indexPath.row][@"commentBody"];
    NSLog(@"%@",cell);
    NSLog(@"%@",cell.contentView);
    return cell;
}

#pragma mark - commentButton press

-(void)commentButtonPress:(UIButton*)button{
    
   __weak commentViewController *weakSelf=self;
    
    commentView *co=[[commentView alloc]init];
    
    [co popUpCommentViewWithCommitBlock:^(NSString *commentBody) {
        NSMutableDictionary *dic= [[NSMutableDictionary alloc]initWithDictionary:weakSelf.commentRequestData];
//        [weakSelf.commentRequestData setObject:@"comment" forKey:commentBody];
        dic[_commentContentKey]=commentBody;
        self.commentRequestData=[[NSDictionary alloc]initWithDictionary:dic];
        [NetworkCenter AFRequestWithData:self.commentRequestData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            
            
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
//            [self _requestList];
            
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
            
            //@根据映射字典把服务器返回json的字段映射到本地字段如commentAuthor->userName,commentContent->commentBody
            NSEnumerator *keyEnumerator=[_commentListKeyMapping keyEnumerator];
            NSString *key;
            while((key=[keyEnumerator nextObject])!=nil){
                    [targetDic setObject:sourceDic[key]  forKey:_commentListKeyMapping[key]];
            }
            
            
            
            
//            [targetDic setObject:sourceDic[@"userName"]  forKey:@"userName"];
//            [targetDic setObject:sourceDic[@"comment"] forKey:@"commentBody"];
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
            
            //@根据映射字典把服务器返回json的字段映射到本地字段如commentAuthor->userName,commentContent->commentBody
            NSEnumerator *keyEnumerator=[_commentListKeyMapping keyEnumerator];
            NSString *key;
            while((key=[keyEnumerator nextObject])!=nil){
                [targetDic setObject:sourceDic[key]  forKey:_commentListKeyMapping[key]];
            }
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


