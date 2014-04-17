//
//  EditPersonalInformation.m
//  UESTCPioneer
//
//  Created by 张众 on 3/26/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "EditPersonalInformation.h"
#import "constant.h"
#import "CellForEditPersonalInformation.h"
#import "CellForEditPersonalInformation_FirstCell.h"
@interface EditPersonalInformation ()
{
    NSArray *array;
    int tag;
    UIImage *pickedImage;
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
    
    
    
    //隐藏默认返回按钮
    [self.navigationItem setHidesBackButton:YES];
    
    //修改左边button
    UIBarButtonItem *leftBarButton  =[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    
    //修改背景色为白色
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    //修改字体为红色
    [self.navigationController.navigationBar setTintColor:kNavigationBarColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigationBarColor}];
    
    //修改顶部运营商和时间为黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CellForEditPersonalInformation class] forCellReuseIdentifier:@"setcell"];
    [self.tableView registerClass:[CellForEditPersonalInformation_FirstCell class] forCellReuseIdentifier:@"Firstcell"];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    array = @[@"头像",@"昵称",@"姓名",@"性别",@"民族",@"籍贯",@"原始密码",@"新的密码",@"确认密码"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"修改信息";
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(complete:)];
    self.navigationItem.rightBarButtonItem = right;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //还原顶部设置
    [self.navigationController.navigationBar setBarTintColor:kNavigationBarColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)complete:(id)sender
{
    
}

#pragma mark actionSheet delegate and imagePicker

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                self.pickImage.allowsEditing = YES;
                self.pickImage.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:self.pickImage animated:YES completion:NULL];
                break;
            default:
                break;
        }
    }
    else
    {
        switch (buttonIndex) {
            case 0:
                self.pickImage.allowsEditing = YES;
                self.pickImage.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:self.pickImage animated:YES completion:NULL];
                break;
            case 1:
                self.pickImage.allowsEditing = NO;
                self.pickImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:self.pickImage animated:YES completion:NULL];
            default:
                break;
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
        pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    else
        pickedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [((CellForEditPersonalInformation_FirstCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).touXiang setBackgroundImage:pickedImage forState:UIControlStateNormal];
    //[self.thumbnail setBackgroundImage:pickedImage forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:NULL];
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
    if (indexPath.section == 0 &&indexPath.row ==0)
    {
        static NSString *CellIdentifier = @"Firstcell";
        CellForEditPersonalInformation_FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CellForEditPersonalInformation_FirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.staticLabel.text = array[indexPath.row];
        [cell.touXiang addTarget:self.choseImageSheet action:@selector(showInView:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"setcell";
        CellForEditPersonalInformation *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CellForEditPersonalInformation alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.staticLabel.text = array[indexPath.row + 1];
        cell.textfield.placeholder = [NSString stringWithFormat:@"请输入您的%@",array[indexPath.row + 1]];
        cell.textfield.delegate = self;
        return cell;
    }
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
    [((CellForEditPersonalInformation *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(tag < 1 ? tag + 1 : tag -1) inSection:(tag < 1 ? 0 : 1)]]).textfield resignFirstResponder];
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

#pragma mark - Lazy initialization
- (UIActionSheet *)choseImageSheet
{
    if (!_choseImageSheet)
    {
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            _choseImageSheet = [[UIActionSheet alloc]
                                initWithTitle:nil
                                delegate:self
                                cancelButtonTitle:@"取消"
                                destructiveButtonTitle:@"拍照"
                                otherButtonTitles:@"从手机相册选择",nil];
        }
        else
        {
            _choseImageSheet = [[UIActionSheet alloc]
                                initWithTitle:nil
                                delegate:self
                                cancelButtonTitle:@"取消"
                                destructiveButtonTitle:@"从手机相册选择"
                                otherButtonTitles:nil];
        }
    }
    return _choseImageSheet;
}

- (UIImagePickerController *)pickImage
{
    if (!_pickImage) {
        _pickImage = [[UIImagePickerController alloc] init];
        _pickImage.delegate = self;
    }
    return _pickImage;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
