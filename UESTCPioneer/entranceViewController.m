//
//  entranceViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-4-2.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "entranceViewController.h"

@interface entranceViewController (){
    UILabel *welcomeLabel;
}

@end

@implementation entranceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithLabelTextArray:(NSArray*)array{
    self = [super init];
    if (self){
        
        //标题栏
        
        welcomeLabel=[[UILabel alloc]init];
        [welcomeLabel setTextAlignment:NSTextAlignmentCenter];
        [welcomeLabel setText:@"欢迎登陆成电先锋"];
        [self.view addSubview:welcomeLabel];
        [welcomeLabel setTextColor:kNavigationBarColor];
        
        [welcomeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[welcomeLabel(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(welcomeLabel)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[welcomeLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(welcomeLabel)]];
        
        //分割线
        UIImageView *seperator = [[UIImageView alloc]init];
        [seperator setImage:[UIImage imageNamed:@"sepline"]];
        [self.view addSubview:seperator];
        [seperator setContentMode:UIViewContentModeRedraw];
        [seperator setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[seperator]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(seperator)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[seperator(==0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(seperator)]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:seperator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:seperator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        
        //背景
        UIImageView *backgroundImageView = [[UIImageView alloc]init];
        [backgroundImageView setImage:[UIImage imageNamed:@"inputkuang"]];
        [self.view addSubview:backgroundImageView];
        [backgroundImageView setContentMode:UIViewContentModeRedraw];
        [backgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[backgroundImageView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImageView)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[backgroundImageView]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImageView)]];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
