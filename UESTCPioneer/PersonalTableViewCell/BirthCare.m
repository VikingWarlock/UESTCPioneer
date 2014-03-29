//
//  BirthCare.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "BirthCare.h"
#import "constant.h"
#import "BirthCareCell.h"
@interface BirthCare ()

@end

@implementation BirthCare

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
    if(IS_IOS7)
        self.tableView.separatorInset = UIEdgeInsetsZero;
    [self setExtraCellLineHidden];
    [self.tableView setAllowsSelection:NO];
    [self.tableView registerClass:[BirthCareCell class] forCellReuseIdentifier:@"setcell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"生日提醒";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"setcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    return cell;
}

- (void)sendWish:(id)sender
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250,17, 60, 30)];
    label.text = @"已送祝福";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
    [((UIButton *)sender).superview.superview addSubview:label];
    [((UIButton *)sender) setFrame:CGRectMake(230, 25, 15, 15)];
    [((UIButton *)sender) setBackgroundImage:[UIImage imageNamed:@"already.png"] forState:UIControlStateNormal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(void)setExtraCellLineHidden
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
