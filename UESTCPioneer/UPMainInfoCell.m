//
//  UPMainInfoCell.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPMainInfoCell.h"

#define wholeNewsButtonColor         [UIColor colorWithRed:93.0/255.0 green:107.0/255.0 blue:142.0/255.0 alpha:1]




@interface newsImage : UIImageView

@end

@implementation newsImage
-(id)initWithIndex:(NSInteger)index{
    
    CGRect rect =CGRectMake(10+index*(imageViewWidth+10), 115, imageViewWidth, imageViewWidth);
    
    self=[super initWithFrame:rect];
    if (self){
    
    }
    return self;
}

@end

@interface UPMainInfoCell(){
    UIButton *btnLabel;
    NSArray *imageViewArray;
}

@end

@implementation UPMainInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    _hasImage=NO;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect wordsRect = CGRectMake(5, 3, 290, 80);
        UILabel *wordsLabel = [[UILabel alloc]initWithFrame:wordsRect];
        wordsLabel.font = [UIFont systemFontOfSize:wordsFontSize];
        wordsLabel.tag = wordsTag;
        wordsLabel.textColor = [UIColor blackColor];
        wordsLabel.lineBreakMode = NSLineBreakByWordWrapping;
        wordsLabel.numberOfLines = 0;
        [wordsLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:wordsLabel];
        
        CGRect btnRect = CGRectMake(5, 85, 40, 20);
        btnLabel = [[UIButton alloc]initWithFrame:btnRect];
        btnLabel.titleLabel.font = [UIFont systemFontOfSize:16];
        btnLabel.tag = 1;
        


        [btnLabel setTitleColor:wholeNewsButtonColor forState:UIControlStateNormal];
        [btnLabel setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btnLabel setTitle:@"全文" forState:UIControlStateNormal];
        [btnLabel addTarget:self action:@selector(WholeNewsContentButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [btnLabel.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:btnLabel];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setNewsBody:(NSString*)newsBody{
    UILabel *words = (UILabel *)[self.contentView viewWithTag:wordsTag];
    words.text = newsBody;
}

-(void)WholeNewsContentButtonPress:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(WholeNewsButtonClick:)]){
        [self.delegate WholeNewsButtonClick:self.theId];
    }
}


-(void)setHasImage:(BOOL)hasImage{
    _hasImage=hasImage;
    if (_hasImage){
        
        //如果设置过就不用再设置
        if ([imageViewArray count])return;
        
//        CGRect btnRect =btnLabel.frame;
//        btnRect.origin.y+=imageViewWidth+20;
//        [btnLabel setFrame:btnRect];
        
        
        
        NSMutableArray *mut  = [[NSMutableArray alloc]init];
        for (NSInteger i=0;i<4;i++){
            newsImage *imageV = [[newsImage alloc]initWithIndex:i];
            [self addSubview:imageV];
            [mut addObject:imageV];
        }
        imageViewArray=[[NSArray alloc]initWithArray:mut];
        
    }
    else {
        //有图片框才处理
        if ([imageViewArray count]) {
            for (newsImage *v in imageViewArray){
                [v removeFromSuperview];
            }
            imageViewArray=nil;
        }
    }
}


///直接把url字符串数组传入，函数会自动下载图片并显示
-(void)setImageUrlArray:(NSArray *)imageUrlArray{
    _imageUrlArray=imageUrlArray;
    if([imageUrlArray count]==0){
        [self setHasImage:NO];
    }
    else {
        [self setHasImage:YES];
        
        
        NSInteger length =[imageUrlArray count];
        if(length>4)length=4;
        for (NSInteger i=0;i<length;i++){
            newsImage *v = imageViewArray[i];
//            [v setImageWithURL:[NSURL URLWithString:imageUrlArray[i]]];
            [v setImageWithURL:[NSURL URLWithString:imageUrlArray[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                
            }];

        }
        
    
    }
}





@end
