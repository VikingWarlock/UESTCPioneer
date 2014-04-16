//
//  inputRectView.m
//  UESTCPioneer
//
//  Created by Sway on 14-4-3.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "inputRectView.h"
#define kEachInputFieldHeight 40
@interface inputRectView(){
    UIView *preSeperator,*preLabel;
    
}
@end

@implementation inputRectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithLabelTextArray:(NSArray*)array{
    self = [super init];
    if (self){
    

        //背景
        UIView *backgroundImageView = [[UIView alloc]init];
        //        [backgroundImageView setImage:[UIImage imageNamed:@"inputkuang"]];

        [backgroundImageView.layer setCornerRadius:5];
        [backgroundImageView.layer setBorderWidth:1];
        [backgroundImageView.layer setBorderColor:[UIColor colorWithWhite:146.0/255.0 alpha:0.5].CGColor];
//        [backgroundImageView setContentMode:UIViewContentModeRedraw];
                [self addSubview:backgroundImageView];
        [backgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[backgroundImageView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImageView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImageView)]];




        NSMutableArray *tempFieldArray = [[NSMutableArray alloc]init];

        for (NSInteger i=0;i<array.count;i++){
    //分割线
    UIImageView *seperator = [[UIImageView alloc]init];
    [seperator setImage:[UIImage imageNamed:@"sepline"]];
    [backgroundImageView addSubview:seperator];
    [seperator setContentMode:UIViewContentModeRedraw];
    [seperator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [backgroundImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[seperator]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(seperator)]];
    [backgroundImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[seperator(==0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(seperator)]];
    //            [self addConstraint:[NSLayoutConstraint constraintWithItem:seperator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    //            [self addConstraint:[NSLayoutConstraint constraintWithItem:seperator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    //标签

           UILabel* label = [[UILabel alloc]init];
            [label setText:array[i]];
            [backgroundImageView addSubview:label];
            [label setTranslatesAutoresizingMaskIntoConstraints:NO];
            [backgroundImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[label(==100)]|" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(label)]];
         [backgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kEachInputFieldHeight]];
            
            
    //输入框
#warning  为了省时间暂时这么hack满足注册页面
            id textField;
            
            if (i>=3&&i<=6){
                textField = [[UILabel alloc]init];
            }
            else textField = [[UITextField alloc]init];
            [backgroundImageView addSubview:textField];
            [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
            [tempFieldArray addObject:textField];
            
    if (i==0){
        [backgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:seperator attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeTop multiplier:1 constant:kEachInputFieldHeight]];
        
        
                    [backgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    }
    else {
        
        [backgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:seperator attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:preSeperator attribute:NSLayoutAttributeBottom multiplier:1 constant:kEachInputFieldHeight]];
        [backgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:preLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    }
    preSeperator=seperator;
            preLabel=label;

            [backgroundImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[preLabel][textField]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(preLabel,textField)]];
                        [backgroundImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[textField(==preLabel)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(preLabel,textField)]];
            [backgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:preLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
            
}
        [backgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:preLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [preSeperator removeFromSuperview];
        
        
        _TextFieldArray=tempFieldArray;
}
    
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
