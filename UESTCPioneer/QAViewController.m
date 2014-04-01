//
//  QAViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "QAViewController.h"

@interface QAViewController ()

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UITextView  * questTV;
@property (nonatomic,strong) UIToolbar * toolBar;
@property (nonatomic,strong) UIButton * completeBtn;
@property (nonatomic,strong) UIButton * cancelBtn;
@property (nonatomic,strong) UILabel * tvLabel;


@end

@implementation QAViewController



static NSString * cellIdentifier = @"cellIdentifier";

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.toolBar addSubview:self.questTV];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.toolBar];
    
    [self registerForKayboardNotifications];
   // self.questField.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-100) style:UITableViewStyleGrouped];
 //       _tableView.backgroundColor = self.backGroundColor;
        _tableView.allowsSelection = NO;
        
    }
    return _tableView;
}




-(UITextView *)questTV{
    if (!_questTV) {
        _questTV = [[UITextView alloc] initWithFrame:CGRectMake(20, 5, self.view.frame.size.width - 30, 25)];
        _questTV.editable = YES;
        _questTV.text = @"写问题";
        _questTV.backgroundColor = self.tableView.backgroundColor;
        _questTV.delegate = self;
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

- (NSArray *)questArr{
    if (!_questArr) {
        _questArr = @[@"请问下入党需要准备什么材料？"];
    }
    return _questArr;
}


- (UIButton *)completeBtn{
    if (!_completeBtn) {
        _completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
        [_completeBtn setBackgroundImage:[UIImage imageNamed:@"complete1.png"] forState:UIControlStateNormal];
        _completeBtn.enabled = NO;
    }
    return _completeBtn;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 12, 15, 15)];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.questTV.frame = CGRectMake(20, 40, 280, 130);
    self.questTV.text = NULL;
    
    
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
        [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"complete2.png"] forState:UIControlStateNormal];
        [self.completeBtn addTarget:self action:@selector(completeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

- (void)cancelBtnClick:(UIButton *)sender{
    [self.questTV resignFirstResponder];
    [self toolBarChanged];
    self.completeBtn.enabled = NO;

}

- (void)completeBtnClick:(UIButton *)sender {
    [self.questTV resignFirstResponder];
    [self toolBarChanged];
    self.completeBtn.enabled = NO;

}

- (void)toolBarChanged{
    self.completeBtn.hidden = YES;
    self.cancelBtn.hidden = YES;
    self.tvLabel.hidden = YES;
    self.toolBar.frame = CGRectMake(0, self.tableView.frame.origin.y + self.tableView.frame.size.height , self.view.frame.size.width , 135);
    self.questTV.frame = CGRectMake(20, 5, self.view.frame.size.width - 30, 25);
    if (self.questTV.text.length == 0) {
        self.questTV.text = @"写问题";
    }
}

- (void)registerForKayboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
     
}

- (void)keyboardWasShown:(NSNotification *)aNotification{
    NSDictionary * info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.toolBar.frame.origin.y - kbSize.height - 150, self.view.frame.size.width, self.toolBar.frame.size.height + 180);
    
    [UIView commitAnimations];
}

- (void)toolBarChangeWithSize: (CGSize) kbSize {
    self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.toolBar.frame.origin.y - kbSize.height - 150, self.view.frame.size.width, self.toolBar.frame.size.height + 180);
    self.questTV.frame = CGRectMake(20, 40, 280, 130);
    self.questTV.text = NULL;
    
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

- (void) keyboardWillBeHidden:(NSNotification *)aNotification{
    NSDictionary * info = [aNotification userInfo];
    CGSize kbSize = [[ info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, self.toolBar.frame.origin.y + kbSize.height + 50, self.view.frame.size.width, self.toolBar.frame.size.height - 50);
    [UIView commitAnimations];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.questArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [self.tableView.backgroundColor copy];
    cell.textLabel.text = self.questArr[indexPath.row];
    
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
