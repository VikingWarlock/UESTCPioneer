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
#import "FirstEditCell.h"
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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[EditCell class] forCellReuseIdentifier:@"setcell"];
    [self.tableView registerClass:[FirstEditCell class] forCellReuseIdentifier:@"Firstcell"];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    array = @[@"头像",@"昵称",@"姓名",@"性别",@"民族",@"籍贯",@"原始密码",@"新的密码",@"确认密码"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(complete:)];
    self.navigationItem.rightBarButtonItem = right;
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
    [((FirstEditCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).touXiang setBackgroundImage:pickedImage forState:UIControlStateNormal];
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
        FirstEditCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[FirstEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.staticLabel.text = array[indexPath.row];
        [cell.touXiang addTarget:self.choseImageSheet action:@selector(showInView:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"setcell";
        EditCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[EditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
    [((EditCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(tag < 1 ? tag + 1 : tag -1) inSection:(tag < 1 ? 0 : 1)]]).textfield resignFirstResponder];
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
