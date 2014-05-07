//
//  TheoryDetailViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "TheoryDetailViewController.h"

@interface TheoryDetailViewController ()
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UITextView * contentView;

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


- (id) initWithDictionary:(NSDictionary *)data{
    if (self) {
        self.data = data;
    }
    return self;
}

- (NSDictionary *) data{
    if (!_data) {
        _data = @{@"title":@"饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿",@"content":@"饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿饿"};
    }
    return _data;
}

/*
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 ,0 , 0, 0)];
        _titleLabel.numberOfLines = 0;
        NSString * newsTitle = self.data[@"title"];
        UIFont * titleFont = [UIFont boldSystemFontOfSize:18.0];
        CGSize titleSize = CGSizeMake(310, 2000);
        CGSize tLabelSize = [newsTitle sizeWithFont:titleFont constrainedToSize:titleSize lineBreakMode:NSLineBreakByWordWrapping];
        _titleLabel.frame = CGRectMake(5.0, 10.0, tLabelSize.width , tLabelSize.height);
        if (_titleLabel.frame.size.height<22) {
            _titleLabel.frame = CGRectMake(5.0, 10.0, 320, 22);
        }
        _titleLabel.text = newsTitle;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = titleFont;
        _titleLabel.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
        
    }
    return _titleLabel;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情";
    
    
    CGRect rect = self.view.frame;
    rect.size.height = rect.size.height - 67;
    rect.origin.y = 3;
    _contentView = [[UITextView alloc] initWithFrame:rect];
    _contentView.editable = NO;
    _contentView.text = self.data[@"content"];
    
    NSString * title = [[[self.data[@"title"] stringByAppendingString:@"\n"] stringByAppendingString:@"______________________________________________"] stringByAppendingString:@"\n\n"];
    NSString * content = [title stringByAppendingString:self.data[@"content"]];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary * attributes = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]};
    NSRange range = [content rangeOfString:self.data[@"title"]];
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:content];
    [attrStr addAttributes:attributes range:range];
    [attrStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]} range:[content rangeOfString:self.data[@"content"]]];
    [_contentView setAttributedText:attrStr];
    _contentView.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    
    
    [self.view addSubview:_contentView];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
