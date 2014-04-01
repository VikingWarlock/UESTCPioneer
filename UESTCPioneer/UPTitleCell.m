//
//  UPTitleCell.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPTitleCell.h"

@interface UPTitleCell(){
    UIButton *collectButton;
}

@end

@implementation UPTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        _CollectButtonEnable=NO;
        _collecting=NO;

        
        
        CGRect titleRect = CGRectMake(10, 10, 250, 20);
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:titleRect];
        titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
        titleLabel.tag = titleTag;
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:titleLabel];
        
        CGRect timeRect = CGRectMake(10, 30, 250, 20);
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:timeRect];
        timeLabel.font = [UIFont systemFontOfSize:timeFontSize];
        timeLabel.tag = timeTag;
        timeLabel.textColor = [UIColor grayColor];
        [timeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:timeLabel];
        
      
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitle:(NSString*)title{
    UILabel *titleLabel = (UILabel *)[self.contentView viewWithTag:titleTag];
    titleLabel.text=title;
}

-(void)setTime:(NSString*)time{
            UILabel *timeLabel = (UILabel *)[self.contentView viewWithTag:timeTag];
    timeLabel.text=time;
}

-(void)setCollectButtonEnable:(BOOL)CollectButtonEnable{
    _CollectButtonEnable=CollectButtonEnable;
    if (CollectButtonEnable){
        if (collectButton!=nil)return;
        
        CGRect collectRect = CGRectMake(230, 20, 60, 20);
        UIButton *collect = [[UIButton alloc]initWithFrame:collectRect];
        collectButton=collect;
        collect.tag = collectTag;
//        collect.hidden = YES;
        [collect setImage:[UIImage imageNamed:@"collect.png"] forState:UIControlStateNormal];
        [collect setImage:[UIImage imageNamed:@"collect_highlighted.png"] forState:UIControlStateHighlighted];
        [collect setImage:[UIImage imageNamed:@"collect_highlighted.png"] forState:UIControlStateSelected];
        [collect addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:collect];

    }
    else {
        [collectButton removeFromSuperview];
        collectButton=nil;
    }
}

-(void)collect:(UIButton*)button{
    button.selected=!button.selected;
    if ([self.delegate respondsToSelector:@selector(UPTitleCell:CollectButtonClick:)]){
        [self.delegate UPTitleCell:self CollectButtonClick:button];
    }
}

-(void)setCollectButtonStatus:(BOOL)status{
    if (status){
        collectButton.selected=YES;
    }
    else {
        collectButton.selected=NO;
    }
}




@end
