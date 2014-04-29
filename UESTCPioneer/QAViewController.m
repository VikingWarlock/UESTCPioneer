//
//  QAViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "QAViewController.h"
#import "PartyDataQAEntity.h"
#import "QATableViewCell.h"


@interface QAViewController (){
    UIImageView * tvImageView;
    NSString * text;
}

@property (nonatomic,strong) UITextView  * questTV;
@property (nonatomic,strong) UIToolbar * toolBar;
@property (nonatomic,strong) UIButton * completeBtn;
@property (nonatomic,strong) UIButton * cancelBtn;
@property (nonatomic,strong) UILabel * tvLabel;



@end

@implementation QAViewController



static NSString * cellIdentifier = @"cellIdentifier";

- (id)init{
    self = [super init];
    if (self) {
        self.title = @"Q&A";
        entityName = @"PartyDataQAEntity";
        entityMapping = [Mapping PartyDataQAEntityMapping];
        requestData = @{@"type":@"getQandA",@"page":@"1"};
    }
    return self;
}

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.completeBtn addTarget:self action:@selector(completeBtnClick:) forControlEvents:UIControlEventTouchUpInside];//****
    
    
    [self.toolBar addSubview:self.questTV];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.toolBar];
    
    [self registerForKayboardNotifications];
    // self.questField.delegate = self;
    
    // Do any additional setup after loading the view.
}


-(void)_loadUPTableView{
    self.tableView=[[UPTableView alloc]initWithFrame:CGRectMake(0, 0, 320,470) style:UITableViewStyleGrouped];
    self.tableView.tag = 27;
    [self.view addSubview:self.tableView];
}


-(UITextView *)questTV{
    if (!_questTV) {
        _questTV = [[UITextView alloc] initWithFrame:CGRectMake(15, 5, self.view.frame.size.width - 30, 25)];
        _questTV.editable = YES;
        _questTV.backgroundColor = self.tableView.backgroundColor;
        _questTV.delegate = self;
        _questTV.font = [UIFont systemFontOfSize:13];
        _questTV.textContainerInset = UIEdgeInsetsMake(5, 21, 5, 15);

        _questTV.layer.borderWidth = 1;
        _questTV.layer.borderColor = [[UIColor colorWithWhite:185.0/255.0 alpha:1] CGColor];
        _questTV.text = @"写问题";
        _questTV.textColor = [UIColor colorWithWhite:149.0/255.0 alpha:1];

        tvImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"write1.png"]];
        tvImageView.frame = CGRectMake(5, 5, 15, 15);
        [_questTV addSubview:tvImageView];
        
        
    }
    return _questTV;
}

-(UILabel *)tvLabel{
    if (!_tvLabel) {
        _tvLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 200, 20)];
    }
    return _tvLabel;
}

- (UIToolbar *)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.tableView.frame.origin.y + self.tableView.frame.size.height , self.view.frame.size.width , 135)];
    }
    return _toolBar;
}



- (UIButton *)completeBtn{
    if (!_completeBtn) {
        _completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(270, 0, 40, 40)];
        _completeBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [_completeBtn setImage:[UIImage imageNamed:@"complete1.png"] forState:UIControlStateNormal];
     //   [_completeBtn setBackgroundImage:[UIImage imageNamed:@"complete1.png"] forState:UIControlStateNormal];
        _completeBtn.enabled = NO;
        
    }
    return _completeBtn;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 2, 35, 35)];
        _cancelBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [_cancelBtn setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{

  //  self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.toolBar.frame.origin.y - keyBoardHeight - 50, self.view.frame.size.width, self.toolBar.frame.size.height - 50);

    [self.tableView setScrollEnabled:NO];
    [self.tableView setAllowsSelection:NO];
    self.questTV.frame = CGRectMake(20, 40, 280, 130);
    self.questTV.textContainerInset = UIEdgeInsetsZero;
    self.questTV.text = text;
    self.questTV.font = [UIFont systemFontOfSize:16];
    self.questTV.textColor = [UIColor blackColor];
    tvImageView.hidden = YES;
    
    self.tvLabel.center = CGPointMake(self.view.frame.size.width/2, 20);
    self.tvLabel.text = @"写问题";
    self.tvLabel.textAlignment = NSTextAlignmentCenter;
    self.tvLabel.hidden = NO;
    self.cancelBtn.hidden = NO;
    self.completeBtn.hidden = NO;
    
    [self.toolBar addSubview:self.tvLabel];
    [self.toolBar addSubview:self.completeBtn];
    [self.toolBar addSubview:self.cancelBtn];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.questTV.text.length != 0) {
        self.completeBtn.enabled = YES;
        [self.completeBtn setImage:[UIImage imageNamed:@"complete2.png"] forState:UIControlStateNormal];
    }else
        self.completeBtn.enabled = NO;
    text = textView.text;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.questTV.font = [UIFont systemFontOfSize:13];
    [self.tableView setScrollEnabled:YES];
}

- (void)cancelBtnClick:(UIButton *)sender{
    [self.questTV resignFirstResponder];
    [self toolBarChanged];
}

- (void)completeBtnClick:(UIButton *)sender {
    [self.questTV resignFirstResponder];
    [self toolBarChanged];
    self.completeBtn.enabled = NO;
    
    [NetworkCenter AFRequestWithData:@{@"type":@"question",@"userId":[constant getUserId],@"userName":[constant getUserName],@"que":text}   SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"result"] isEqualToString:@"success"]){
                [Alert showAlert:@"发布问题成功!"];
                text = NULL;
                self.questTV.text = text;
                [self.tableView beginRefreshing];
            }
            else {
                [Alert showAlert:@"发布问题失败!"];
            }

    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"网络请求失败!"];
    }];
}

- (void)toolBarChanged{
    self.completeBtn.hidden = YES;
    self.cancelBtn.hidden = YES;
    self.tvLabel.hidden = YES;
    self.toolBar.frame = CGRectMake(0, self.tableView.frame.origin.y + self.tableView.frame.size.height , self.view.frame.size.width , 135);
    self.questTV.frame = CGRectMake(self.questTV.frame.origin.x, 5, self.view.frame.size.width - 30, 25);
    if (self.questTV.text.length == 0) {
        self.questTV.text = @"写问题";
        self.questTV.textColor = [UIColor colorWithWhite:149.0/255.0 alpha:1];
        tvImageView.hidden = NO;
        self.questTV.textContainerInset = UIEdgeInsetsMake(5, 21, 5, 15);
    }else{
        self.questTV.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
        self.questTV.textColor = [UIColor blackColor];
    }


}

- (void)registerForKayboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardChange:(NSNotification *)aNotification{
    NSDictionary * info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
 /*
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationBeginsFromCurrentState:YES];
  */
    [UIView animateWithDuration:[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]
                     animations:^{
                         self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.tableView.frame.origin.y + self.tableView.frame.size.height - kbSize.height - 150, self.view.frame.size.width, self.toolBar.frame.size.height + 180);
                     }];
    NSLog(@"aaa");

  //  [UIView commitAnimations];
}

- (void)keyboardwillHidden:(NSNotification *)aNotification{
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * aCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    QATableViewCell * cell = (QATableViewCell *)aCell;
    if (cell.ansView.hidden) {
        return cell.queLabel.frame.origin.y + cell.queLabel.frame.size.height + 10;
    }else
        return cell.ansView.frame.origin.y + cell.ansView.frame.size.height + 10;
 
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableViewEntitiesArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QATableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    PartyDataQAEntity * entity = tableViewEntitiesArray[indexPath.row];
    if (cell == nil) {
        cell = [[QATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = self.tableView.backgroundColor;
    cell.userNameLabel.text = entity.userName;
    cell.queTimeLabel.text = entity.time_que;
    cell.queLabel.text = entity.question;
    cell.ansNameLabel.text = [NSString stringWithFormat:@"%@回复:",entity.answerName];
    cell.ansLabel.text = entity.answer;
    cell.ansTimeLabel.text = entity.time_ans;
    
    [cell setLayoutWithQue:entity.question Ans:entity.answer];
    
    if (cell.ansLabel.text.length == 0) {
        cell.ansView.hidden = YES;
    }else
        cell.ansView.hidden = NO;

    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
-(void)pullDownRefresh:(MJRefreshBaseView *)refreshView{
 [NetworkCenter AFRequestWithData:requestData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
 
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
 */
@end
