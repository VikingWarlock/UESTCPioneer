//
//  StartActivity.m
//  UESTCPioneer
//
//  Created by 张众 on 3/26/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "StartActivity.h"
#import "CellForStartActivity.h"
#import "StartActivity_displaySelectedImage.h"
@interface StartActivity ()
{
        //edit by @黄卓越 ：移到头文件
//    BOOL isFirstEdit1;
    BOOL isFirstEdit2;

    BOOL isTitleNotNull;
    BOOL isBodyNotNull;
    NSMutableArray *pickedImage;//用来保存pick的图片
    NSIndexPath *index;//用成员变量保存每次点击的item是哪一个
    int increment;//插入、删除item的时候要给代理方法加上或者减去一个增量否则报错
    
}
@end

@implementation StartActivity

-(NSMutableArray*)getPickedImageArray{
    return pickedImage;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        isFirstEdit1 = YES;
        isFirstEdit2 = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pickedImage = [[NSMutableArray alloc] initWithCapacity:4];
    [self.tableView addSubview:self.editBody];
    [self.tableView addSubview:self.editTitle];
    [self.tableView addSubview:self.collectionview];
    [self.collectionview registerClass:[CellForStartActivity class] forCellWithReuseIdentifier:@"GradientCell"];
    [self.collectionview setScrollEnabled:NO];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"发起活动";
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"发起" style:UIBarButtonItemStyleDone target:self action:@selector(commit:)];
    self.navigationItem.rightBarButtonItem = right;
    
    if (self.editBody.text.length && self.editTitle.text.length && !isFirstEdit1 && !isFirstEdit2)
        self.navigationItem.rightBarButtonItem.enabled = YES;
    else
        self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
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

- (void)commit:(id)sender
{
    NSDictionary *requestD = @{@"userId":[constant getUserId]
                               ,@"eventTitle":[helper urlencode:self.editTitle.text]
                               ,@"userName":[constant getUserName]
                               ,@"content":[helper urlencode:self.editBody.text]
                               ,@"type":@"EventPublish"
                               };
    
    
    
    [NetworkCenter requestActivity:requestD ImageArray:[self getPickedImageArray] SuccessBlock:^(id resultObject) {
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:Nil];
        if ([dic[@"result"] isEqualToString:@"success"]){
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
        }
        else {
            [Alert showAlert:@"发生错误"];
        }
    } failure:^(NSError *error) {
        [Alert showAlert:@"发生错误"];
    }];
}

#pragma mark actionSheet delegate and imagePicker

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                self.pickImage.allowsEditing = YES;
                self.pickImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
    {
        ((CellForStartActivity *)[self.collectionview cellForItemAtIndexPath:index]).thumbnail.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [pickedImage addObject:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    }
    else
    {
        ((CellForStartActivity *)[self.collectionview cellForItemAtIndexPath:index]).thumbnail.image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        [pickedImage addObject:[info objectForKey:@"UIImagePickerControllerEditedImage"]];
    }
    increment ++;
    [self.collectionview insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:index.row + 1 inSection:0]]];
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

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.editBody.text.length && self.editTitle.text.length && !isFirstEdit1 && !isFirstEdit2)
        self.navigationItem.rightBarButtonItem.enabled = YES;
    else
        self.navigationItem.rightBarButtonItem.enabled = NO;
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

#pragma mark - collection view delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1 + increment;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GradientCell";
    CellForStartActivity * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[CellForStartActivity alloc] init];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellForStartActivity * cell = (CellForStartActivity *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.thumbnail.image == nil) {
        [self.choseImageSheet showInView:self.tableView];
    }
    else
    {
        StartActivity_displaySelectedImage *vc = [[StartActivity_displaySelectedImage alloc] init];
        vc.imageview.image = pickedImage[indexPath.row];
        
        UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deletePicture)];
        vc.navigationItem.rightBarButtonItem = right;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    index = indexPath;
}

- (void)deletePicture
{
    [self.navigationController popViewControllerAnimated:YES];
    increment--;
    ((CellForStartActivity *)[self.collectionview cellForItemAtIndexPath:index]).thumbnail.image = nil;
    [self.collectionview deleteItemsAtIndexPaths:[NSArray arrayWithObject:index]];
    [pickedImage removeObjectAtIndex:index.row];
    [self.collectionview reloadData];
    NSLog(@"%@",pickedImage);
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
        [_editBody setScrollEnabled:NO];
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

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 12, 10, 12);
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 270, 300, 80) collectionViewLayout:layout];
        _collectionview.layer.borderColor = [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1] CGColor];
        _collectionview.layer.borderWidth = 1.0;
        _collectionview.layer.cornerRadius = 4.0;
        _collectionview.backgroundColor = [UIColor whiteColor];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
    }
    return _collectionview;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
