//
//  TheoryDetailViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "TheoryDetailViewController.h"

@interface TheoryDetailViewController ()
@property UILabel * titleLabel;
@property UILabel * contentLabel;

@end

@implementation TheoryDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSDictionary *) data{
    if (!_data) {
        _data = @{@"title":@"饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿",@"content":@"饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿"};
    }
    return _data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 ,0 , 0, 0)];
    _titleLabel.numberOfLines = 0;
    NSString * newsTitle = self.data[@"title"];
    UIFont * titleFont = [UIFont boldSystemFontOfSize:18.0];
    CGSize titleSize = CGSizeMake(310, 2000);
    CGSize tLabelSize = [newsTitle sizeWithFont:titleFont constrainedToSize:titleSize lineBreakMode:NSLineBreakByWordWrapping];
    _titleLabel.frame = CGRectMake(5.0, 10.0, tLabelSize.width , tLabelSize.height);
    _titleLabel.text = newsTitle;
    _titleLabel.font = titleFont;
    _titleLabel.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UIView * seplineView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleLabel.frame.origin.y +_titleLabel.frame.size.height + 15.0, self.view.bounds.size.width, 1)];
    seplineView.backgroundColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1];
    
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    _contentLabel.numberOfLines = 0;
    NSString * newsContent = self.data[@"content"];
    UIFont * font = [UIFont boldSystemFontOfSize:15];
    CGSize size = CGSizeMake(300, 5000);
    CGSize labelSize = [newsContent sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    _contentLabel.frame = CGRectMake(10.0, seplineView.frame.origin.y + 15, labelSize.width,labelSize.height);
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.text = newsContent;
    _contentLabel.font = font;
    _contentLabel.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    
    
    [self.view addSubview:seplineView];
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_contentLabel];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
