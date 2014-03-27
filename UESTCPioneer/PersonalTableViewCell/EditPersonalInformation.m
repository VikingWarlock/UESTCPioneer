//
//  EditPersonalInformation.m
//  UESTCPioneer
//
//  Created by 张众 on 3/26/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "EditPersonalInformation.h"
#import "constant.h"
#import "EditCell.h"
@interface EditPersonalInformation ()
{
    NSArray *array;
    int tag;
}
@end

@implementation EditPersonalInformation

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    [self.tableView registerClass:[EditCell class] forCellReuseIdentifier:@"setcell"];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    array = @[@"头像",@"昵称",@"姓名",@"性别",@"民族",@"籍贯",@"原始密码",@"新的密码",@"确认密码"];

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 )
        return 2;
    else if (section == 1)
        return 7;
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"setcell";
    EditCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[EditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0 &&indexPath.row ==0)
    {
        cell.staticLabel.text = array[indexPath.row];
        [cell.staticLabel setFrame:CGRectMake(10, 10, 70, cell.frame.size.height)];
        cell.touXiang.image = [UIImage imageNamed:@"touxiang.png"];
        [cell.textfield removeFromSuperview];
    }
    else
    {
        cell.staticLabel.text = array[indexPath.row + 1];
        cell.textfield.placeholder = [NSString stringWithFormat:@"请输入您的%@",array[indexPath.row + 1]];
    }
    cell.textfield.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 64;
    }
    else return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [((EditCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(tag <= 1 ? tag : tag -2) inSection:(tag <= 1 ? 0 : 1)]]).textfield resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    tag = textField.tag;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
