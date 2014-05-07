//
//  GuideDetailViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//
#import "GuideDetailViewController.h"
#import "PartyDataGuideDetailEntity.h"

@interface GuideDetailViewController ()

@property UILabel * titleLabel;
@property UITextView * contentView;
@property UILabel * timeLabel;
@property PartyDataGuideDetailEntity * entity;
@property UIAlertView * alert;

@end

@implementation GuideDetailViewController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithData:(NSDictionary*)data{
    if (self) {
        self.data = data;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.alert = [[UIAlertView alloc]initWithTitle:nil message:@"加载中..."  delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [self.alert show];
    [NetworkCenter RKRequestWithData:@{@"type":@"getOneZhinan",@"id":self.data[@"newsId"]} EntityName:@"PartyDataGuideDetailEntity" Mapping:[Mapping PartyDataGuideDetailEntityMapping] SuccessBlock:^(NSArray *resultArray) {
        self.entity = resultArray[0];
    } failure:^(NSError *error) {
        NSLog(@"加载失败");
    }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   /*
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 ,0 , 0, 0)];
    _titleLabel.numberOfLines = 0;
    NSString * newsTitle = self.data[@"newsTitle"];
    UIFont * titleFont = [UIFont boldSystemFontOfSize:18.0];
    CGSize titleSize = CGSizeMake(320, 2000);
    CGSize tLabelSize = [newsTitle sizeWithFont:titleFont constrainedToSize:titleSize lineBreakMode:NSLineBreakByWordWrapping];
    _titleLabel.frame = CGRectMake(5.0, 10.0, tLabelSize.width - 10.0, tLabelSize.height);
    if (_titleLabel.frame.size.height<22) {
        _titleLabel.frame = CGRectMake(5.0, 10.0, 320, 22);
    }
    _titleLabel.text = newsTitle;
    _titleLabel.font = titleFont;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleLabel.frame.origin.y + _titleLabel.frame.size.height +5, 320, 20)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:13.0];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.text = self.entity.time;
    
    */

    _contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, 5, 320, self.view.frame.size.height-5)];
    _contentView.editable = NO;
    
    NSString * content = [[[[self.entity.title stringByAppendingString:@"\n"] stringByAppendingString:self.entity.time] stringByAppendingString:@"\n______________________________________________\n\n"] stringByAppendingString:self.entity.content];
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle * paragStyle = [[NSMutableParagraphStyle alloc] init];
    paragStyle.lineSpacing = 8.0;
    paragStyle.alignment = NSTextAlignmentCenter;
    [attrStr addAttributes:@{NSParagraphStyleAttributeName:paragStyle,NSFontAttributeName: [UIFont boldSystemFontOfSize:18]} range:[content rangeOfString:self.entity.title]];
    [attrStr addAttributes:@{NSParagraphStyleAttributeName:paragStyle,NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:[content rangeOfString:self.entity.time]];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1]} range:[content rangeOfString:self.entity.content]];
    
    [_contentView setAttributedText:attrStr];

    
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
//    [self.view addSubview:_timeLabel];
//    [self.view addSubview:seplineView];
//    [self.view addSubview:_titleLabel];
    [self.view addSubview:_contentView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
