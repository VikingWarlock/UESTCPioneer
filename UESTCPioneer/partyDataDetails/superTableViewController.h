//
//  superTableViewController.h
//  UESTCPioneer
//
//  Created by 马君 on 14-4-12.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface superTableViewController : UITableViewController{
    NSArray * tableViewEntitiseArray;
}

-(void)downloadDataWithRequestData:(NSDictionary *)RequestData EntityName:(NSString*)EntityName Mapping:(NSDictionary *)Mapping;

@end
