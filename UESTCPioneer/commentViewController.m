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

@interface commentTableView : UITableView


@end

@implementation commentTableView



@end



@interface commentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    commentTableView *TableView;
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
    [TableView setBackgroundColor:backgroundColor];
    TableView=[[commentTableView alloc]initWithFrame:self.view.bounds];
    [TableView registerClass:[commentTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:TableView];
    TableView.delegate=self;
    TableView.dataSource=self;
    
    

    
    
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

    
    
    

    [NetworkCenter AFRequestWithData:@{@"type":@"getShareComment",@"page":@"1",@"shareId":[NSString stringWithFormat:@"%d",self.theId]} SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        
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
        [TableView reloadData];
        
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"commentViewController init request error:%@",error);
    }];
    
    
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
    [cell.headImageView setImageWithURL:tableViewDataArray[indexPath.row][@"headImageUrl"] placeholderImage:[UIImage imageNamed:@"touxiang.png"]];
    
    cell.userName.text=tableViewDataArray[indexPath.row][@"userName"];
    cell.commentBody.text=tableViewDataArray[indexPath.row][@"commentBody"];
    return cell;
}

#pragma mark - commentButton press

-(void)commentButtonPress:(UIButton*)button{
    
    
    [commentView popUpCommentView];

}

@end


