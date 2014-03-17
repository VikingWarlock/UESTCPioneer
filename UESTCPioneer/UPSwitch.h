//
//  UPSwitch.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-6.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPSwitch : UIButton
-(void)setOnBacgroundImage:(UIImage*)onImage;
-(void)setOffBacgroundImage:(UIImage*)offImage;
-(void)setOnBacgroundColor:(UIImage*)onColor;
-(void)setOffBacgroundColor:(UIImage*)offColor;
@property(nonatomic,readonly)BOOL On;
@end

@protocol UPSwitchDelegate <NSObject>

@end