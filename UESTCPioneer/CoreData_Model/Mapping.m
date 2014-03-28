//
//  Mapping.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-28.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "Mapping.h"

@implementation Mapping


+(NSDictionary*)PioneerMapping{
    //{"comeCode":"school","comeFrom":"电子科技大学校党委","content":" 3月20日，电子
    //    "count":0,"desc":"","id":35,"picName":"","picUrl":{},"time":"2014年03月26日 11:22","title":"新闻测试——百余家用人单位来校揽才","type":"","zipPicUrl":{}},
    NSArray *keyArray =@[@"comeCode",@"comeFrom",@"content",@"count",@"desc",@"id",@"picName",@"picUrl",@"time",@"title",@"type",@"zipPicUrl"];
    NSArray *valueArray=@[@"comeCode",@"comeFrom",@"newsBody",@"numberOfComment",@"desc",@"theId",@"picName",@"picUrl",@"timeAndDate",@"titleBody",@"type",@"zipPicUrl"];
    return [NSDictionary dictionaryWithObjects:valueArray forKeys:keyArray];
}


@end
