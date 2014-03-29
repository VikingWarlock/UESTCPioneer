//
//  RefreshRequestViewController.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-28.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UPMainViewController.h"
#import "EntityHeader.h"

@interface RefreshRequestViewController : UPMainViewController<UITableViewDelegate,UITableViewDataSource>{
    NSDictionary *requestData;
    NSString *entityName;
    NSDictionary *entityMapping;

}

@end
