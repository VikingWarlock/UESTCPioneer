//
//  DailyCare.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "DailyCare.h"
#import "constant.h"
#import "ShortMainInfoCell.h"
#import "ShortTitleCell.h"
@interface DailyCare ()

@end

@implementation DailyCare

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setAllowsSelection:NO];
    [self.tableView registerClass:[ShortTitleCell class] forCellReuseIdentifier:@"CustomTitleCellIndentifier"];
    [self.tableView registerClass:[ShortMainInfocell class] forCellReuseIdentifier:@"CustomMainCellIndentifier"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"日常关怀";
    
    UIImageView *customView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:customView.bounds];
    [customView addSubview:button];
    [button setImage:[UIImage imageNamed:@"write.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendCare:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)sendCare:(id)sender
{
    
}

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

//表的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
        ShortTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier];
        if(cell == nil){
            cell = [[ShortTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTitleCellIndentifier];
        }
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_head_image.png"]];
        img.frame = CGRectMake(5, 5, 45, 45);
        [cell.contentView addSubview:img];
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:titleTag];
        title.frame = CGRectMake(60, 10, 250, 20);
        title.text = @"title";
        UILabel *time = (UILabel *)[cell.contentView viewWithTag:timeTag];
        time.frame = CGRectMake(60, 30, 250, 20);
        time.text = @"time";
        return cell;
    }
    else if (indexPath.row == 1) {
        static NSString *customMainCellIndentifier = @"CustomMainCellIndentifier";
        ShortMainInfocell *cell2 = [tableView dequeueReusableCellWithIdentifier:customMainCellIndentifier];;
        if(cell2 == nil){
            cell2 = [[ShortMainInfocell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customMainCellIndentifier];
        }
        UILabel *words = (UILabel *)[cell2.contentView viewWithTag:wordsTag];
        words.text = @"在讨论这部纪录片之前，为了避免现在中文网络江湖盛行的动机论，我先要说明：我和崔永元老师没有个人恩怨，相反，对他的主持功力和以前取得的成绩都非常钦佩。我们也至少有一名共同的好朋友，《读库》的出版人张立宪。";
        return cell2;
    }
    return nil;
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
        return 0;
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

