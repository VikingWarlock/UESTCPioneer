//
//  MyMessage.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "MyMessage.h"
#import "constant.h"
#import "LongCell.h"
#import "PopCell.h"
@interface MyMessage ()
{
    int i;
    BOOL isSelected;
    BOOL choseMessageCell;
    NSIndexPath *popIndex;
    NSIndexPath *clickIndex;
}
@end

@implementation MyMessage

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
    [self.tableView registerClass:[LongCell class] forCellReuseIdentifier:@"setcell"];
    [self.tableView registerClass:[PopCell class] forCellReuseIdentifier:@"setpopcell"];
    if(IS_IOS7)
        self.tableView.separatorInset = UIEdgeInsetsZero;
    [self setExtraCellLineHidden];
    popIndex = [NSIndexPath indexPathForRow:-1 inSection:0];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"我的消息";
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
    return 3 + i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!choseMessageCell)
    {
        static NSString *CellIdentifier = @"setcell";
        LongCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[LongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.leftImage.image = [UIImage imageNamed:@"mm.png"];
        cell.label.text = @"天气通知";
        return cell;
    }
    else
    {
        static NSString *PopCellIdentifier = @"setpopcell";
        PopCell *popcell = [tableView dequeueReusableCellWithIdentifier:PopCellIdentifier];
        if (popcell == nil) {
            popcell = [[PopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PopCellIdentifier];
        }
        popcell.label.text = @"xxx祝您生日快乐!";
        choseMessageCell = NO;
        return popcell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *indexOfInsert = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    [self.tableView beginUpdates];
    if (isSelected == NO)
    {
        [((LongCell *)[self.tableView cellForRowAtIndexPath:indexPath]).leftImage removeFromSuperview];
        i++;
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexOfInsert] withRowAnimation:UITableViewRowAnimationTop];
        isSelected = YES;
        choseMessageCell = YES;
#warning magic number following!!!
        UIButton *mask = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        [self.view insertSubview:mask aboveSubview:self.view];
        [mask addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.scrollEnabled = NO;
    }
    popIndex = indexOfInsert;
    clickIndex = indexPath;
    [self.tableView endUpdates];
}

- (void)popBack:(id)sender
{
    i--;
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:popIndex] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView deselectRowAtIndexPath:clickIndex animated:NO];
    isSelected = NO;
    [sender removeFromSuperview];
    self.tableView.scrollEnabled = YES;
}

-(void)setExtraCellLineHidden
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

