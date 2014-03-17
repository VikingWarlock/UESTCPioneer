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

@interface PartyNoticeViewController ()

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
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text=@"党委通知";
    label.center=self.view.center;
    

    
    [self.view addSubview:label];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

-(void)viewWillAppear:(BOOL)animated{
        [self.leveyTabBarController.navigationItem setTitle:@"党委通知"];
}

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

//表的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (void)collectTaped:(UIButton *)collect{
    UITableViewCell *cell = (UITableViewCell *)[[[collect superview]superview]superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //收藏
    [collect setImage:[UIImage imageNamed:@"collect_highlighted.png"] forState:UIControlStateNormal];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
        UPTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier];
        if(cell == nil){
            cell = [[UPTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTitleCellIndentifier];
        }
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:titleTag];
        title.text = @"title";
        UILabel *time = (UILabel *)[cell.contentView viewWithTag:timeTag];
        time.text = @"time";
        UIButton *collect = (UIButton *)[cell.contentView viewWithTag:collectTag];
        collect.hidden = NO;
        [collect addTarget:self action:@selector(collectTaped:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if (indexPath.row == 1) {
        static NSString *customMainCellIndentifier = @"CustomMainCellIndentifier";
        UPMainInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:customMainCellIndentifier];;
        if(cell2 == nil){
            cell2 = [[UPMainInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customMainCellIndentifier];
        }
        UILabel *words = (UILabel *)[cell2.contentView viewWithTag:wordsTag];
        words.text = @"在讨论这部纪录片之前，为了避免现在中文网络江湖盛行的动机论，我先要说明：我和崔永元老师没有个人恩怨，相反，对他的主持功力和以前取得的成绩都非常钦佩。我们也至少有一名共同的好朋友，《读库》的出版人张立宪。";
        return cell2;
    }
    else {
        static NSString *customFooterCellIndentifier = @"CustomFooterCellIndentifier";
        UPFooterCell *cell3 = [tableView dequeueReusableCellWithIdentifier:customFooterCellIndentifier];;
        if(cell3 == nil){
            cell3 = [[UPFooterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customFooterCellIndentifier];
        }
        UIButton *btn1 = (UIButton *)[cell3.contentView viewWithTag:btn1Tag];
        UIButton *btn2 = (UIButton *)[cell3.contentView viewWithTag:btn2Tag];
        UIButton *btn3 = (UIButton *)[cell3.contentView viewWithTag:btn3Tag];
        btn1.hidden = NO;
        btn2.hidden = NO;
        
        [btn1 setImage:[UIImage imageNamed:@"read.png"] forState:UIControlStateNormal];
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
    if (section == 0) {
        return 10;
    }
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
