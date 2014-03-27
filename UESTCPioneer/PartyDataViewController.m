//
//  PartyDataViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "PartyDataViewController.h"
#import "LeveyTabBarController.h"
#import "helper.h"
#import "TheoryViewController.h"
#import "PersonalViewController.h"
#import "OrganTableViewController.h"
#import "GuideTableViewController.h"
#import "LearnTableViewController.h"
@interface PartyDataViewController ()
@property (nonatomic,strong) NSDictionary * dic;
//@property (nonatomic,strong) NSMutableArray * views;
@property (nonatomic,strong) NSArray * controllers;
@end

@implementation PartyDataViewController

- (NSDictionary *) dic{
    if (!_dic) {
        _dic = @{@"中央精神": @"censpi.png",@"党的知识":@"knowledge.png",@"党的理论":@"theory.png",@"党校学习":@"learn.png",@"入党流程":@"process.png",@"组织架构":@"organ.png",@"办事指南":@"guide.png",@"Q&A":@"QA.png",@"专业学习":@"spcail.png"};
    }
    return _dic;
}

- (NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] init];
        NSArray * arr = @[@"中央精神",@"党的知识",@"党的理论",@"党校学习",@"入党流程",@"组织架构",@"办事指南",@"Q&A",@"专业学习"];
        for (int i = 0; i < 3; i ++) {
            for (int j = 0;  j < 3; j++) {
                UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(j*100+15, i*110+15, 90, 100)];
                [btn.layer setBorderWidth:1.0f];
                [btn.layer setBorderColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8].CGColor];
                UIImage * image = [helper getCustomImage:[UIImage imageNamed:self.dic[arr[i*3+j]]] insets:UIEdgeInsetsMake(20, 30, 63, 60)];
                [btn setBackgroundImage:image forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(60, 20, 0, 20)];
                btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
                [btn setTitle:arr[i*3+j] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(aButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_buttons addObject:btn];
            }
        }
    }
    return _buttons;
}

- (NSArray *) controllers{
    if (!_controllers) {
        _controllers = @[[[TheoryViewController alloc] init],[[TheoryViewController alloc] init],[[TheoryViewController alloc] init],[[LearnTableViewController alloc] initWithStyle:UITableViewStyleGrouped],[[OrganTableViewController alloc] init],[[OrganTableViewController alloc] initWithStyle:UITableViewStyleGrouped],[[GuideTableViewController alloc]initWithStyle:UITableViewStyleGrouped]];
    }
    return _controllers;
}


/*-(NSMutableArray *)views{
 if (!_views) {
 _views = [[NSMutableArray alloc] init];
 for (int i = 1; i < 3;  i ++) {
 for (int j = 0; j<3; j++) {
 UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i*100+10, j*110+20, 1, 90)];
 [view setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
 [_views addObject:view];
 
 UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(j*100+20, i*110+10, 80, 1)];
 [view2 setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
 [_views addObject:view2];
 }
 }
 }
 return _views;
 }
 */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) aButtonClicked:(UIButton *)sender{
    UIViewController * viewController = self.controllers[[self.buttons indexOfObject:sender]];
    [self.leveyTabBarController.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setUserInteractionEnabled:YES];
    for (UIButton * btn in self.buttons) {
        [self.view addSubview:btn];
    }
    
    /*    for (UIView * view in self.views) {
     [self.view addSubview:view];
     }
     */
}

-(void)viewWillAppear:(BOOL)animated{
    [self.leveyTabBarController.navigationItem setTitle:@"资料"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
