//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIDropDown ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@end

@implementation NIDropDown
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize delegate;

- (id)initDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr {
    btnSender = b;
    self = [super init];
    if (self) {
        // Initialization code
        CGRect btn = b.frame;
        UIImageView *xiala = (UIImageView *)[b viewWithTag:22];
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
        self.list = [NSArray arrayWithArray:arr];
//        self.layer.masksToBounds = NO;
//        self.layer.cornerRadius = 8;
//        self.layer.shadowOffset = CGSizeMake(-5, 5);
//        self.layer.shadowRadius = 5;
//        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        table.scrollEnabled = NO;
        table.delegate = self;
        table.dataSource = self;
//        table.layer.cornerRadius = 5;
        //table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];
        [table setSeparatorInset:UIEdgeInsetsZero];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.18];
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
        table.frame = CGRectMake(0, 0, btn.size.width, *height);
        [xiala.layer setAffineTransform:CGAffineTransformMakeRotation(0.5f * 3.14159*2)];
        [UIView commitAnimations];
        
        [b.superview.superview addSubview:self];
        [self addSubview:table];
        UITableView *supertable = (UITableView *)[b.superview.superview viewWithTag:27];
        supertable.userInteractionEnabled = NO;
    }
    return self;
}

-(void)hideDropDown:(UIButton *)b {
    CGRect btn = b.frame;
    UIImageView *xiala = (UIImageView *)[b viewWithTag:22];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.18];
    self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    table.frame = CGRectMake(0, 0, btn.size.width, 0);
    [xiala.layer setAffineTransform:CGAffineTransformMakeRotation(0)];
    [UIView commitAnimations];
    UITableView *supertable = (UITableView *)[b.superview.superview viewWithTag:27];
    supertable.userInteractionEnabled = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}   


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text =[list objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor colorWithRed:0.240 green:0.240 blue:0.240 alpha:1];
    if ([cell.textLabel.text isEqualToString:btnSender.titleLabel.text]) {
        cell.backgroundColor = [UIColor colorWithRed:0.180 green:0.180 blue:0.180 alpha:1];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self hideDropDown:btnSender];
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    
    
    //代理的运行时安全判断
    if ([self.delegate respondsToSelector:@selector(niDropDownDelegateMethod:ForTitle:ForIndex:)]){
        [self.delegate niDropDownDelegateMethod:self ForTitle:list[indexPath.row] ForIndex:indexPath.row];
    }
    
//    [self.delegate niDropDownDelegateMethod:<#(NIDropDown *)#> ForTitle:<#(NSString *)#> ForIndex:<#(NSInteger)#>];
//        [self.delegate niDropDownDelegateMethod:self ForTitle:<#(NSString *)#> ForIndex:<#(NSInteger)#>]
//    [self myDelegate];
}

//- (void) myDelegate {
//    [self.delegate niDropDownDelegateMethod:self ForTitle:<#(NSString *)#> ForIndex:<#(NSInteger)#>]
//}

//-(void)dealloc {
//    [super dealloc];
//    [table release];
//    [self release];
//}

@end
