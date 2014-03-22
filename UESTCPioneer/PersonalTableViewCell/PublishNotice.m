//
//  PublishNotice.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "PublishNotice.h"

@interface PublishNotice ()

@end

@implementation PublishNotice

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, 300, 30)];
    title.layer.borderColor = [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1] CGColor];
    title.layer.borderWidth =1.0;
    title.layer.cornerRadius =4.0;
    title.delegate = self;
    
    
    UITextView *body = [[UITextView alloc] initWithFrame:CGRectMake(10, 60, 300, 200)];
    body.layer.borderColor = [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1] CGColor];
    body.layer.borderWidth =1.0;
    body.layer.cornerRadius =4.0;
    body.delegate = self;
    
    
    UIView *layoutImage = [[UIView alloc] initWithFrame:CGRectMake(10, 270, 300, 80)];
    layoutImage.layer.borderColor = [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1] CGColor];
    layoutImage.layer.borderWidth =1.0;
    layoutImage.layer.cornerRadius =4.0;
    layoutImage.backgroundColor = [UIColor whiteColor];
    UIButton *thumbnail = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    [thumbnail setBackgroundImage:[UIImage imageNamed:@"addpic.png"] forState:UIControlStateNormal];
    [layoutImage addSubview:thumbnail];
    
    [self.view addSubview:layoutImage];
    [self.view addSubview:body];
    [self.view addSubview:title];
    // Do any additional setup after loading the view.
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
