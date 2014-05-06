//
//  commentViewController.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-22.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableViewController.h"

@interface commentViewController : RefreshTableViewController
@property (nonatomic) NSInteger numberOfComment;
@property NSDictionary *commentListRequestData;
//用于将编写的评论提交到服务器的参数Dictionary
@property NSDictionary *commentRequestData;

///评论内容请求的key
@property NSString *commentContentKey;

///评论列表返回内容的键和本地键不一样
@property NSDictionary *commentListKeyMapping;
@end
