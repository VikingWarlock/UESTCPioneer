//
//  RefreshRequestViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-28.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "RefreshRequestViewController.h"
#import "PioneerNewsEntity.h"
#import "UPTitleCell.h"
#import "UPMainInfoCell.h"
#import "UPFooterCell.h"


static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
static NSString *customMainCellIndentifier = @"CustomMainCellIndentifier";
static NSString *customFooterCellIndentifier = @"CustomFooterCellIndentifier";
@interface RefreshRequestViewController ()<UPMainInfoCellDelegate,UPTitleCellDelegate,UPFooterCellDelegate>{

    NSMutableDictionary *_cellHeightDictionary;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@implementation RefreshRequestViewController





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)_initRequestRequireEntityName:(NSString*)EntityName EntityMapping:(NSDictionary*)EntityMapping RequestData:(NSDictionary*)RequestData CommentListRequestData:(NSDictionary*)CommentListRequestData CommentWriteRequestData:(NSDictionary*)CommentWriteRequestData CommentIdKey:(NSString*)CommentIdKey CommentContentKey:(NSString*)CommentContentKey CommentListKeyMapping:(NSDictionary*)CommentListKeyMapping{

    entityName=EntityName;
    entityMapping=EntityMapping;
    requestData=RequestData;
    //请求评论列表用的参数
    commentListRequestData=CommentListRequestData;
    //写评论请求用的参数
    commentWriteRequestData=CommentWriteRequestData;
    commentIdKey=CommentIdKey;
    commentContentKey=CommentContentKey;
    commentListKeyMapping=CommentListKeyMapping;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tableView registerClass:[UPTitleCell class] forCellReuseIdentifier:customTitleCellIndentifier];
    [self.tableView registerClass:[UPMainInfoCell class] forCellReuseIdentifier:customMainCellIndentifier];
    [self.tableView registerClass:[UPFooterCell class] forCellReuseIdentifier:customFooterCellIndentifier];
    
            _cellHeightDictionary=[[NSMutableDictionary alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - refresh request


-(void)pullDownRefresh:(MJRefreshBaseView *)refreshView{
    [PublicMethod ClearEntity:entityName];
    [NetworkCenter RKRequestWithData:requestData EntityName:entityName Mapping:entityMapping SuccessBlock:^(NSArray *resultArray) {
        
        NSMutableArray *dic=    [[NSMutableArray alloc]init];
        [dic addObjectsFromArray:resultArray];
        
        tableViewEntitiesArray=[[NSArray alloc]initWithArray:dic];
        
        
        
        
        
//        for (PioneerNewsEntity* entity in tableViewEntitiesArray){
//            NSLog(@"%@",entity.titleBody);
//        }
        
        
        
//        [PublicMethod ClearEntity:entityName];
        [self.tableView reloadData];
        PullUpRefreshTimes=0;
        [refreshView endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@ 下拉请求失败",entityName);
        [refreshView endRefreshing];
    }];
}
-(void)pullUpRefresh:(MJRefreshBaseView *)refreshView{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:requestData];
    [dic setObject:[NSString stringWithFormat:@"%d",PullUpRefreshTimes+2] forKey:@"page"];
    

    
    [NetworkCenter RKRequestWithData:dic EntityName:entityName Mapping:entityMapping SuccessBlock:^(NSArray *resultArray) {
        
        for (PioneerNewsEntity* entity in tableViewEntitiesArray){
            NSLog(@"%@",entity.titleBody);
        }
        
        if ([resultArray count]==0){
            [refreshView endRefreshing];
            return ;
        }
        
        NSMutableArray *newArray = [[NSMutableArray alloc]init];
        [newArray addObjectsFromArray:tableViewEntitiesArray];
        [newArray addObjectsFromArray:resultArray];
        NSArray *result = [[NSArray alloc]initWithArray:newArray];
        
        
        tableViewEntitiesArray=result;
        
//        [PublicMethod ClearEntity:entityName];
        [self.tableView reloadData];
        
        //清除core data 因为现在还没有适合下拉刷新和适合本地缓存的api

        [refreshView endRefreshing];
        PullUpRefreshTimes++;
        
    } failure:^(NSError *error) {
        NSLog(@"%@ 上拉error:%@",entityName,error);
        [refreshView endRefreshing];
    }];
}

-(void)commentButtonPress:(commentButton*)button{
    commentViewController *comment = [[commentViewController alloc]init];
    
    
    //    1）type：writeShareComment  （2）user_id：用户的账号
    //    （3）username：用户姓名      （4）shareId：活动分享的id
    //    （5）comment：评论的内容
    
    
    //请求评论列表用的参数
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:commentListRequestData];
    [dic setObject:[NSString stringWithFormat:@"%d",button.theId] forKey:commentIdKey];
    commentListRequestData=[[NSDictionary alloc]initWithDictionary:dic];
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]initWithDictionary:commentWriteRequestData];
    [temp setObject:[NSString stringWithFormat:@"%d",button.theId] forKey:commentWriteIdKey];
    commentWriteRequestData=[[NSDictionary alloc]initWithDictionary:temp];
    
    
    comment.commentListRequestData=commentListRequestData;
    //写评论请求用的参数
    comment.commentRequestData=commentWriteRequestData;
    comment.commentContentKey=commentContentKey;
    comment.commentListKeyMapping=commentListKeyMapping;
    comment.numberOfComment=[button.titleLabel.text integerValue];
    
    
    [self.leveyTabBarController.navigationController pushViewController:comment animated:YES];
}

#pragma mark - 全文按钮事件

//代理函数
-(void)WholeNewsButtonClick:(NSInteger)theId{
    
    NewsEntity *entity = [PublicMethod entity:kNewsEntityName WithId:theId];
    NSString *content=entity.newsBody;
    UIViewController *viewController = [[UIViewController alloc]init];
    UITextView *textView = [[UITextView alloc]init];
    
    [viewController.view addSubview:textView];
    [textView setText:content];
    [textView setEditable:NO];
    [textView setScrollEnabled:YES];
    [textView setFont:[UIFont systemFontOfSize:18]];
    
    [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [viewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textView]|" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(textView)]];
    [viewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textView]|" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(textView)]];
    

    [self.leveyTabBarController.navigationController pushViewController:viewController animated:YES];
}



#pragma mark - tableView Cell dequeue 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"super tableview delegate");
    
    NewsEntity *entity= tableViewEntitiesArray[indexPath.section];
    if (indexPath.row == 0) {
        //6.0后用这种方式更直接，可以省掉if（cell2＝＝nil）的判断   @黄卓越 2014-3-28
        UPTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier forIndexPath:indexPath];
        cell.theId=[entity.theId integerValue];
        [cell setTitle:entity.titleBody];
        [cell setTime:entity.timeAndDate];
        
        
        return cell;
    }
    else if (indexPath.row == 1) {
        
        
        //6.0后用这种方式更直接，可以省掉if（cell2＝＝nil）的判断   @黄卓越 2014-3-28
        UPMainInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:customMainCellIndentifier forIndexPath:indexPath];;
        NSDictionary *pic=entity.picUrl;
        NSArray *ImageUrlArray=[pic  allValues];
        
        
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        for (NSString *suffix in ImageUrlArray){
            [temp addObject:[baseUrl stringByAppendingString:suffix]];
        }
        
        NSArray *urlArray = [[NSArray alloc]initWithArray:temp];
        

        [cell2 setImageUrlArray:urlArray];
        //@cell的高度自适应
        if ([cell2 hasImage])_cellHeightDictionary[@(indexPath.section)]=@(110+imageViewWidth);
        else _cellHeightDictionary[@(indexPath.section)]=@(110);
        [cell2 setNewsBody:entity.newsBody];
        cell2.theId=[entity.theId integerValue];
        cell2.delegate=self;
        return cell2;
    }
    else {
        //6.0后用这种方式更直接，可以省掉if（cell2＝＝nil）的判断   @黄卓越 2014-3-28
        UPFooterCell *cell3 = [tableView dequeueReusableCellWithIdentifier:customFooterCellIndentifier forIndexPath:indexPath];;
        cell3.theId=[entity.theId integerValue];
        cell3.delegate=self;
        UIButton *btn1 = (UIButton *)[cell3.contentView viewWithTag:btn1Tag];
        
        
        
        //        commentButton *btn3 = (commentButton *)[cell3.contentView viewWithTag:btn3Tag];
        //        [btn3 setTitle:[entity.numberOfComment stringValue] forState:UIControlStateNormal];
//        NSLog(@"number of comment %@",entity.numberOfComment);
        [cell3 setCommentId:[entity.theId integerValue]];
        [cell3 setCommentNum:[entity.numberOfComment integerValue]];
        [cell3 addCommentButtonTaget:self Action:@selector(commentButtonPress:)];
        
        
        [btn1 setImage:[UIImage imageNamed:@"read.png"] forState:UIControlStateNormal];
        return cell3;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 55;
    }
    else if (indexPath.row == 1){
//        UPMainInfoCell *cell= (UPMainInfoCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
//        if (cell.hasImage)return 110+imageViewWidth;
        
        
        //判断是否有图片以适应高度
        CGFloat height;
        
        NewsEntity *entity =tableViewEntitiesArray[indexPath.section];
        NSDictionary *picDic= entity.picUrl;
        if ([picDic count]==0){
            height=110;
        }
        else {
            height=110+imageViewWidth+30;
        }
        
         return height;
//         return [_cellHeightDictionary[@(indexPath.section)] floatValue];
    }
    else
        return 40;
}

@end
