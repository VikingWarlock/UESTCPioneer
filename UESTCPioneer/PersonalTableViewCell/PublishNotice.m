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
        UIButton *thumbnail = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [thumbnail setBackgroundImage:[UIImage imageNamed:@"addpic.png"] forState:UIControlStateNormal];
        [_layoutImage addSubview:thumbnail];
    }
    return _layoutImage;
}
@end
