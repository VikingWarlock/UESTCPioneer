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
#import "QAViewController.h"
#import "ProcessTableViewController.h"
#import "MLearnTableViewController.h"


@interface PartyDataViewController ()
@property (nonatomic,strong) NSDictionary * dic;
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation PartyDataViewController

- (NSDictionary *) dic{
    if (!_dic) {
        _dic = @{@"中央精神": @"censpi.png",@"党的知识":@"knowledge.png",@"党的理论":@"theory.png",@"党校学习":@"learn.png",@"入党流程":@"process.png",@"组织架构":@"organ.png",@"办事指南":@"guide.png",@"Q&A":@"QA.png",@"专业学习":@"spcail.png"};
    }
    return _dic;
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"中央精神",@"党的知识",@"党的理论",@"党校学习",@"入党流程",@"组织架构",@"办事指南",@"Q&A",@"专业学习"];
    }
    return _titleArray;
}

- (NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 3; i ++) {
            for (int j = 0;  j < 3; j++) {
                UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(j*100+15, i*110+15, 90, 100)];
                [btn.layer setBorderWidth:1.0f];
                [btn.layer setBorderColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8].CGColor];
                UIImage * image = [helper getCustomImage:[UIImage imageNamed:self.dic[self.titleArray[i*3+j]]] insets:UIEdgeInsetsMake(20, 30, 63, 60)];
                [btn setBackgroundImage:image forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(60, 20, 0, 20)];
                btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
                [btn setTitle:self.titleArray[i*3+j] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(aButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_buttons addObject:btn];
            }
        }
    }
    return _buttons;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) aButtonClicked:(UIButton *)sender{
    UIViewController * viewController ;
    switch ([self.buttons indexOfObject:sender]) {
        case 0:
            viewController = [[TheoryViewController alloc] initWithTitle:self.titleArray[0] RequestData:@{@"type": @"studySpirit",@"page":@"1"} EntityName:@"PartyDataSpiritEntity" Mapping:[Mapping PartyDataSpiritEntityMapping]];
            break;
        case 1:
            viewController = [[TheoryViewController alloc] initWithTitle:self.titleArray[1] RequestData:@{@"type": @"studyKnowledge",@"page":@"1"} EntityName:@"PartyDataKnowledgeEntity" Mapping:[Mapping PartyDataSpiritEntityMapping]];
            break;
        case 2:
            viewController = [[TheoryViewController alloc] initWithTitle:self.titleArray[2] RequestData:@{@"type":@"studyTheory",@"page":@"1"} EntityName:@"PartyDataTheoryEntity" Mapping:[Mapping PartyDataSpiritEntityMapping]];
            break;
        case 3:
            viewController = [[LearnTableViewController alloc] initWithRequestData:@{@"type":@"getFilename",@"page":@"1"} entityName:@"PartyDataLearnEntity" Mapping:[Mapping PartyDataLearnEntityMapping]];
            break;
        case 4:
            viewController = [[ProcessTableViewController alloc] init];
            break;
        case 5:
            viewController = [[OrganTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            break;
        case 6:
            viewController = [[GuideTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
            break;
        case 7:
            viewController = [[QAViewController alloc] init];
            break;
        case 8:
            viewController = [[MLearnTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            
        default:
            break;
    }
    [self.leveyTabBarController.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setUserInteractionEnabled:YES];
    for (UIButton * btn in self.buttons) {
        [self.view addSubview:btn];
    }
    
    [self.view setBackgroundColor:ViewControllerBackgroundColor];
    
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
