//
//  StartActivity.m
//  
//
//  Created by 张众 on 3/20/14.
//
//

#import "StartActivity.h"
#import <QuartzCore/QuartzCore.h>

@interface StartActivity ()
{
    BOOL isFirstEdit;
}
@end

@implementation StartActivity

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
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, 300, 250)];
    textView.layer.borderColor = [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1] CGColor];
    textView.layer.borderWidth =1.0;
    textView.layer.cornerRadius =4.0;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
    textView.text = @"请在此输入通知内容...";
    [self.view addSubview:textView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"发起活动";
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
