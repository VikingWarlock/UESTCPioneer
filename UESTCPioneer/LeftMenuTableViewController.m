//
//  LeftMenuTableViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//


#import "LeftMenuTableViewController.h"
#import "UPMenuTableViewCell.h"
#import "PioneerViewController.h"
#import "PartyNoticeViewController.h"
#import "PartyDataViewController.h"
#import "PublicityViewController.h"
#import "PartyActivityViewController.h"
#import "MoodShareViewController.h"
#import "LeveyTabBarController.h"
#import "AppDelegate.h"
#import "helper.h"
#import "constant.h"
@interface LeftMenuTableViewController (){
    NSDictionary *classTypeToUnreadKeyDictionary;
    NSArray *unreadKeyArray;
    NSArray *nameArray ;
    NSArray *classArray;
    NSArray *cellIcon;
    NSArray *selectedCellIcon;
    UIColor *backGroundColor;
    UIColor *separatorColor;
    UIColor *newsCountLabelColor;
    UIColor *textColor;
    UIColor *selectedCellColor;
    NSIndexPath *indexForSelected;
    NSIndexPath *indexForHighlight;
    NSMutableArray *cellsIndex;
    BOOL thisIsJustOneTag;
}

@end

@implementation LeftMenuTableViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        separatorColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
        textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
        newsCountLabelColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
        backGroundColor = [UIColor colorWithRed:37.0/255.0 green:41.0/255.0 blue:50.0/255 alpha:1];
        selectedCellColor = [UIColor colorWithRed:28.0/255.0 green:33.0/255.0 blue:39.0/255.0 alpha:1];
        cellsIndex = [[NSMutableArray alloc] initWithCapacity:5];
        self.tableView.rowHeight = 53;
        if(IS_IOS7)
            self.tableView.separatorInset = UIEdgeInsetsZero;//ios7分割线不同于ios6
        self.tableView.backgroundColor = backGroundColor;
        self.tableView.separatorColor = separatorColor;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[UPMenuTableViewCell class] forCellReuseIdentifier:@"settingCell"];
    [self setExtraCellLineHidden];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayNewsCount:) name:@"newsCount" object:nil];
    indexForSelected = [NSIndexPath indexPathForRow:0 inSection:0];
    nameArray=@[@"成电视角",@"党委通知",@"公示公告",@"组织活动",@"心情分享"];
    classArray=@[[PioneerViewController class],[PartyNoticeViewController class],[PublicityViewController class],[PartyActivityViewController class],[MoodShareViewController class]];
    
    
    //通过类的类型找到其UnreadKey的字典
    unreadKeyArray=@[kUnreadPioneerKey,kUnreadPartyNoticeKey,kUnreadPublicity,kUnreadPartyActivity,kUnreadMoodShare];
    classTypeToUnreadKeyDictionary=[NSDictionary dictionaryWithObjects:unreadKeyArray forKeys:classArray];
    
    
    
    cellIcon = @[@"news1.png",@"notice1.png",@"note1.png",@"act1.png",@"share1.png"];
    selectedCellIcon = @[@"news2.png",@"notice2.png",@"note2.png",@"act2.png",@"share2.png"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((UPMenuTableViewCell *)[self.tableView cellForRowAtIndexPath:indexForSelected]).contentView.backgroundColor = selectedCellColor;
}

-(void)sendToNotificationCenter:(NSMutableArray *)newsCounts
{
    NSNotification *notification = [[NSNotification alloc] initWithName:@"newsCount" object:newsCounts userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    //this place get newsCountLabel's presented number form cache or somewhere else
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"newsCount" object:nil];
}

-(void)displayNewsCount:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[NSMutableArray class]])
    {
        if ([[notification.object objectAtIndex:0] isKindOfClass:[NSString class]])
        {
            for (NSIndexPath *index in cellsIndex) {
                //[((UPMenuTableViewCell *)[self.tableView cellForRowAtIndexPath:index]) showNewsCountLabel:[[notification.object objectAtIndex:index.row] intValue]];
            }
        }
    }
}

#pragma mark - Table view data source

-(void)setExtraCellLineHidden
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [nameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"settingCell";
    UPMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UPMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.titleLabel.text=nameArray[indexPath.row];
    cell.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",cellIcon[indexPath.row]]];
    //未读消息的显示
    NSInteger unreadCount = [Unread getUnreadNumWithKey:unreadKeyArray[indexPath.row]];
    [cell showNewsCountLabel:unreadCount];
    
    
    if(indexForSelected.row == indexPath.row){
        cell.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",selectedCellIcon[indexPath.row]]];
        cell.titleLabel.textColor = [UIColor whiteColor];
    }
    
    if ([cellsIndex count] < 5) {
        [cellsIndex addObject:indexForSelected];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    
    
    //点击消除未读消息
    [Unread setUnreadNum:0 ForKey:unreadKeyArray[indexPath.row]];
    
    //界面切换
    Class theClass=classArray[indexPath.row];
    UIViewController *controller = [[theClass alloc] init];
    [self.leveyTabBarController removeViewControllerAtIndex:0];
    [self.leveyTabBarController setSelectedIndex:1];
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic setObject:[UIImage imageNamed:@"chat.png"] forKey:@"Default"];
	[imgDic setObject:[UIImage imageNamed:@"chat_highlighted.png"] forKey:@"Highlighted"];
	[imgDic setObject:[UIImage imageNamed:@"chat_highlighted.png"] forKey:@"Seleted"];
    [controller willMoveToParentViewController:self.leveyTabBarController];
    [self.leveyTabBarController insertViewController:controller  atIndex:0];
    [self.revealSideViewController popViewControllerWithNewCenterController:[constant getCenterController] animated:YES];
    [self.leveyTabBarController setSelectedIndex:0];
    [controller didMoveToParentViewController:[constant getCenterController]];
    ////////////////////////////////////////////
    
    
    
    UPMenuTableViewCell *cell = (UPMenuTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.titleLabel.textColor = [UIColor whiteColor];
    cell.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",selectedCellIcon[indexPath.row]]];
    cell.contentView.backgroundColor = selectedCellColor;//set selected style

    if(indexForSelected.row != indexPath.row){
        UPMenuTableViewCell *lastCell = (UPMenuTableViewCell *)[self.tableView cellForRowAtIndexPath:indexForSelected];
        lastCell.titleLabel.textColor = textColor;
        lastCell.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",cellIcon[indexForSelected.row]]];
        lastCell.contentView.backgroundColor = backGroundColor;//set last cell back to unselected
    }
    
    [cell.newsCountLabel removeFromSuperview];
    indexForSelected = indexPath;
}

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UPMenuTableViewCell *cell = (UPMenuTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.titleLabel.textColor = [UIColor whiteColor];
    cell.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",selectedCellIcon[indexPath.row]]];
    indexForHighlight = indexPath;
}

-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexForHighlight.row != indexForSelected.row){
        UPMenuTableViewCell *cell = (UPMenuTableViewCell *)[self.tableView cellForRowAtIndexPath:indexForHighlight];
        cell.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",cellIcon[indexForHighlight.row]]];
        cell.titleLabel.textColor = textColor;
    }//这里没有直接使用indexPath是因为在ios6下有bug，indexPath没有正确的指向相应的cell而是返回NSNotFound,不太明白这是怎么回事，所以通过indexForHighlight和indexForSelected绕过了参数indexPath
    NSLog(@"%@",indexPath);
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
