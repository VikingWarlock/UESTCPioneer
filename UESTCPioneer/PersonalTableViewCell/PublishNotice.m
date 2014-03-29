//
//  PublishNotice.m
//  UESTCPioneer
//
//  Created by 张众 on 3/26/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "PublishNotice.h"

@interface PublishNotice ()
{
    BOOL isFirstEdit1;
    BOOL isFirstEdit2;
    UIImage *pickedImage;
    int i;
    id temp;
}
@end

@implementation PublishNotice

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        isFirstEdit1 = YES;
        isFirstEdit2 = YES;
        [self.tableView addSubview:self.editBody];
        [self.tableView addSubview:self.editTitle];
        [self.tableView addSubview:self.layoutImage];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"发布通知";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actionSheet delegate and imagePicker

- (void)popActionSheet:(id)sender
{
    [self.choseImageSheet showInView:self.tableView];
    temp = sender;
}

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
    [temp setBackgroundImage:pickedImage forState:UIControlStateNormal];
    [self.layoutImage addSubview:self.thumbnail];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - textview delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (isFirstEdit1 && textView.tag ==0)
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        isFirstEdit1 = NO;
    }
    if (isFirstEdit2 && textView.tag ==1)
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        isFirstEdit2 = NO;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag ==0 && [textView.text isEqualToString: @""]) {
        textView.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
        textView.text = @"请在此输入活动标题";
        isFirstEdit1 = YES;
    }
    if (textView.tag ==1 && [textView.text isEqualToString: @""]) {
        textView.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
        textView.text = @"请在此输入活动内容...";
        isFirstEdit2 = YES;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hideKeyboard];
}

- (void)hideKeyboard
{
    [self.editTitle resignFirstResponder];
    [self.editBody resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

#pragma mark - Lazy initialization

- (UITextView *)editTitle
{
    if (!_editTitle) {
        _editTitle = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, 300, 30)];
        _editTitle.layer.borderColor = [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1] CGColor];
        _editTitle.layer.borderWidth =1.0;
        _editTitle.layer.cornerRadius =4.0;
        _editTitle.font = [UIFont systemFontOfSize:14];
        _editTitle.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
        _editTitle.text = @"请在此输入活动标题";
        _editTitle.tag = 0;
        _editTitle.delegate = self;
    }
    return _editTitle;
}

- (UITextView *)editBody
{
    if (!_editBody)
    {
        _editBody = [[UITextView alloc] initWithFrame:CGRectMake(10, 60, 300, 200)];
        _editBody.layer.borderColor = [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1] CGColor];
        _editBody.layer.borderWidth =1.0;
        _editBody.layer.cornerRadius =4.0;
        _editBody.font = [UIFont systemFontOfSize:14];
        _editBody.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
        _editBody.text = @"请在此输入活动内容...";
        _editBody.tag = 1;
        _editBody.delegate = self;
    }
    return _editBody;
}

- (UIView *)layoutImage
{
    if (!_layoutImage)
    {
        _layoutImage = [[UIView alloc] initWithFrame:CGRectMake(10, 270, 300, 80)];
        _layoutImage.layer.borderColor = [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1] CGColor];
        _layoutImage.layer.borderWidth =1.0;
        _layoutImage.layer.cornerRadius =4.0;
        _layoutImage.backgroundColor = [UIColor whiteColor];
        [_layoutImage addSubview:self.thumbnail];
    }
    return _layoutImage;
}

- (UIButton *)thumbnail
{
    if(i < 4)
    {
        _thumbnail = [[UIButton alloc] initWithFrame:CGRectMake(12 + (i++)*72, 10, 60, 60)];
        [_thumbnail setBackgroundImage:[UIImage imageNamed:@"addpic.png"] forState:UIControlStateNormal];
        [_thumbnail addTarget:self action:@selector(popActionSheet:) forControlEvents:UIControlEventTouchUpInside];
        return _thumbnail;
    }
    else
        return nil;
}

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
@end
