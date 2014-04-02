//
//  LoginViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-4-2.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController (){
    UILabel *welcomeLabel;
    UITextField *userNameField,*passwordField;
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"登陆帐号";
    
    welcomeLabel=[[UILabel alloc]init];
    [welcomeLabel setTextAlignment:NSTextAlignmentCenter];
    [welcomeLabel setText:@"欢迎登陆成电先锋"];
    [self.view addSubview:welcomeLabel];
    [welcomeLabel setTextColor:kNavigationBarColor];
    
    
    [welcomeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[welcomeLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(welcomeLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[welcomeLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(welcomeLabel)]];
    
    
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
