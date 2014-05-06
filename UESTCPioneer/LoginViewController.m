//
//  LoginViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-4-2.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "LoginViewController.h"
#import "registViewController.h"

@interface inputRect : UIView
@property (nonatomic)UILabel *userNameLabel,*passwordLabel;
@property (nonatomic)UITextField *userNameField,*passwordField;

@end

@implementation inputRect




-(id)init{
    self = [super init];
    if (self){
        
        //背景
        UIImageView *backgroundImageView = [[UIImageView alloc]init];
//        [backgroundImageView setImage:[UIImage imageNamed:@"inputkuang"]];
        [self addSubview:backgroundImageView];
        [backgroundImageView.layer setCornerRadius:5];
        [backgroundImageView.layer setBorderWidth:1];
        [backgroundImageView.layer setBorderColor:[UIColor colorWithWhite:146.0/255.0 alpha:0.5].CGColor];
//        [backgroundImageView setContentMode:UIViewContentModeRedraw];
        [backgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[backgroundImageView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImageView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[backgroundImageView]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImageView)]];
        
        
        //分割线
        UIImageView *seperator = [[UIImageView alloc]init];
        [seperator setImage:[UIImage imageNamed:@"sepline"]];
        [self addSubview:seperator];
        [seperator setContentMode:UIViewContentModeRedraw];
        [seperator setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[seperator]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(seperator)]];
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[seperator(==0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(seperator)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:seperator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:seperator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        //帐号标题
        _userNameLabel=[[UILabel alloc]init];
        _userNameLabel.text=@"帐号：";
        [self addSubview:_userNameLabel];
        [_userNameLabel setAdjustsFontSizeToFitWidth:YES];
        [_userNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_userNameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_userNameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1 constant:10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_userNameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_userNameLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:56]];
        
        _passwordLabel=[[UILabel alloc]init];
        _passwordLabel.text=@"密码：";
        [self addSubview:_passwordLabel];
        [_passwordLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_passwordLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_passwordLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1 constant:10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_passwordLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:_passwordLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:56]];
        
        
        _userNameField=[[UITextField alloc]init];
        [self addSubview:_userNameField];
        [_userNameField setKeyboardType:UIKeyboardTypeEmailAddress];
        [_userNameField setPlaceholder:@"请输入用户名s"];
        [_userNameField setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_userNameField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_userNameLabel attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_userNameField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_userNameField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_userNameField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_userNameLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        
        //密码输入框
        _passwordField=[[UITextField alloc]init];
        [self addSubview:_passwordField];
        [_passwordField setPlaceholder:@"请输入密码"];
        [_passwordField setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_passwordField setSecureTextEntry:YES];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_passwordLabel attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_passwordLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        
        

        
        
        
        
        
        
//        NSLog(@"%@",self.constraints);
//        [self bringSubviewToFront:_userNameLabel];
        
    }
    return self;
}



@end


@interface LoginViewController (){
    UILabel *welcomeLabel;
    UITextField *userNameField,*passwordField;
    inputRect *inputRectV;
    UIButton *registButton,*loginButton;
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
    
    
    //标题
    welcomeLabel=[[UILabel alloc]init];
    [welcomeLabel setTextAlignment:NSTextAlignmentCenter];
    [welcomeLabel setText:@"欢迎登陆成电先锋"];
    [self.view addSubview:welcomeLabel];
    [welcomeLabel setTextColor:kNavigationBarColor];

    //输入框
    inputRectV = [[inputRect alloc]init];
    [self.view addSubview:inputRectV];
    [inputRectV setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    [welcomeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[welcomeLabel(==44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(welcomeLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[welcomeLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(welcomeLabel)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[welcomeLabel][inputRectV(==88)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(inputRectV,welcomeLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[inputRectV]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(inputRectV)]];
    
    userNameField=inputRectV.userNameField;
    passwordField=inputRectV.passwordField;

    //注册按钮
    registButton = [[UIButton alloc]init];
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton.layer setCornerRadius:5];
    [registButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [registButton setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1]];
    [registButton setShowsTouchWhenHighlighted:YES];
    [registButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [registButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:registButton];
    [registButton setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:registButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:inputRectView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[registButton(==100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(registButton)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[inputRectV]-20-[registButton(==34)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(registButton,inputRectV)]];
    
    
    [registButton addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    
    //登陆按钮
    loginButton = [[UIButton alloc]init];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton.layer setCornerRadius:5];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [loginButton setBackgroundColor:kNavigationBarColor];
    [loginButton setShowsTouchWhenHighlighted:YES];
    [loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginButton];
    [loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:registButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:inputRectView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[registButton]-16-[loginButton]-16-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loginButton,registButton)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[inputRectView]-20-[registButton(==34)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(registButton,inputRectView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:loginButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:registButton attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:loginButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:registButton attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    
    
    
    
	// Do any additional setup after loading the view.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [inputRectV.userNameField resignFirstResponder];
    [inputRectV.passwordField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - registButton 
-(void)regist:(UIButton*)button{
    
    NSArray *mut = @[@"昵       称:",@"邮       箱:",@"身份证号:",@"所属党委:",@"所属单位:",@"用户职位:",@"选择支部:",@"输入密码:",@"确认密码:"];
    
    registViewController *registController = [[registViewController alloc]initWithLabelTextArray:mut];
    [self.navigationController pushViewController:registController animated:YES];
    
    
    
    
}

#pragma mark - loginButton  
-(void)login:(UIButton *)button{
    /*
       type=login&userName=cdxf&passwd=123465
     
     */
    
    
    NSDictionary *requestData=@{@"type":@"login"
                                ,@"userName":userNameField.text
                                ,@"passwd":passwordField.text};
    
    [NetworkCenter AFRequestWithData:requestData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dic =arr[0];
        if ([dic[@"result"] isEqualToString:@"success"]){
            [constant setPersonalInfo:dic[@"info"]];
            [constant setName:dic[@"info"][@"name"]];
            [constant setUserId:dic[@"info"][@"userID"]];
            [constant setUserName:dic[@"info"][@"userName"]];
            


            
            
            
            
            

            NSUserDefaults * defaultData = [NSUserDefaults standardUserDefaults];
            [defaultData setObject:dic[@"info"] forKey:@"personalInfo"];
            [defaultData setBool:YES forKey:@"login"];
            [defaultData synchronize];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];
        }
        else {
            [Alert showAlert:@"登陆失败"];
        }
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"发生错误"];
    }];
}


@end


