//
//  TheoryDetailViewController.h
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheoryDetailViewController : UIViewController

@property(nonatomic,strong) NSDictionary * data;
- (id) initWithDictionary:(NSDictionary *)data;

@end
