//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIDropDown;
//代理要继承NSObject
@protocol NIDropDownDelegate<NSObject>

@optional
///学院筛选代理
-(void)niDropDownDelegateMethod:(NIDropDown *)sender ForTitle:(NSString*)title ForIndex:(NSInteger)index;
@end

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) id <NIDropDownDelegate> delegate;

-(void)hideDropDown:(UIButton *)b;
- (id)initDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr;
@end
