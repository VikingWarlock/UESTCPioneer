//
//  entranceViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-4-2.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "entranceViewController.h"

@interface entranceViewController (){

    UIView *preSeperator;


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
        
        
            _inputRect = [[inputRectView alloc]initWithLabelTextArray:array];
                _TextFieldArray=_inputRect.TextFieldArray;
        [self.view addSubview:_inputRect];
        [_inputRect setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[welcomeLabel]-8-[_inputRect]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_inputRect,welcomeLabel)]];
        inputRectTopConstraint =[NSLayoutConstraint constraintWithItem:_inputRect attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:welcomeLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:8];
        [self.view addConstraint:inputRectTopConstraint];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_inputRect]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_inputRect)]];
        

        
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    

    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
