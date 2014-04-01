//
//  PublishNotice.m
//  
//
//  Created by 张众 on 3/20/14.
//
//

#import "PublishNotice.h"
#import <QuartzCore/QuartzCore.h>

@interface PublishNotice ()
{
    BOOL isFirstEdit;
}
@end

@implementation PublishNotice

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1];
        isFirstEdit = YES;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.textView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"发布通知";
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(commit:)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)commit:(id)sender
{
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (isFirstEdit)
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        isFirstEdit = NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.text.length)
        self.navigationItem.rightBarButtonItem.enabled = YES;
    else
        self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - Lazy initialization

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, 300, 250)];
        _textView.layer.borderColor = [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1] CGColor];
        _textView.layer.borderWidth =1.0;
        _textView.layer.cornerRadius =4.0;
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
        _textView.text = @"请在此输入通知内容...";

    }
    return _textView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
