//
//  GuideDetailViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//
#import "GuideDetailViewController.h"

@interface GuideDetailViewController ()

@property UILabel * titleLabel;
@property UITextView * contentView;
@property UILabel * timeLabel;
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    _timeLabel.text = self.data[@"newsTime"];
    
    
    UIView * seplineView = [[UIView alloc] initWithFrame:CGRectMake(0, _timeLabel.frame.origin.y +_timeLabel.frame.size.height + 5.0, self.view.bounds.size.width, 1)];
    seplineView.backgroundColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1];
    
    /*
     _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
     _contentLabel.numberOfLines = 0;
     NSString * newsContent = self.data[@"newsContent"];
     UIFont * font = [UIFont boldSystemFontOfSize:15];
     CGSize size = CGSizeMake(300, 5000);
     CGSize labelSize = [newsContent sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
     _contentLabel.frame = CGRectMake(10.0, seplineView.frame.origin.y + 15, labelSize.width,labelSize.height);
     _contentLabel.textColor = [UIColor blackColor];
     _contentLabel.text = newsContent;
     _contentLabel.font = font;
     _contentLabel.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
     */
    _contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, seplineView.frame.origin.y + seplineView.frame.size.height , 320, 430)];
    _contentView.editable = NO;
    _contentView.text = self.data[@"newsContent"];
    _contentView.font = [UIFont boldSystemFontOfSize:15];
    _contentView.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    
    [self.view addSubview:_timeLabel];
    [self.view addSubview:seplineView];
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_contentView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
