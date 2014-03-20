//
//  PersonalInformation.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "PersonalInformation.h"
#import "constant.h"
#import "ShortCell.h"

@interface PersonalInformation ()
{
    NSArray *array;
}
@end

@implementation PersonalInformation

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
       // UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        //label.text = @"personalInformation";
        //[self.view addSubview:label];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ShortCell class] forCellReuseIdentifier:@"setcell"];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    array = @[@"",@"姓名",@"性别",@"民族",@"籍贯",@"入党时间",@"转正时间",@"政治面貌",@"所属支部"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 4;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"setcell";
    ShortCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section ==0 )
        cell.alabel.text = array[indexPath.row];
    else if (indexPath.section ==1 )
        cell.alabel.text = array[indexPath.row + 1];
    else
        cell.alabel.text = array[indexPath.row + 5];
    // Configure the cell...
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0 ) {
        return nil;
    }
    else if (section ==1 ) {
        return @"   基本信息";
    }
    else if (section == 2 ) {
        return @"   党员信息";
    }
    else return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!section)
        return 10;
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0 )
    {
        return 64;
    }
    else return 44;
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
