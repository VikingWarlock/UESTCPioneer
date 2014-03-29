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
    NSArray *keyArray =@[@"comeCode",@"comeFrom",@"content",@"commentNum",@"desc",@"id",@"picName",@"picUrl",@"time",@"title",@"type",@"zipPicUrl"];
    NSArray *valueArray=@[@"comeCode",@"comeFrom",@"newsBody",@"numberOfComment",@"desc",@"theId",@"picName",@"picUrl",@"timeAndDate",@"titleBody",@"type",@"zipPicUrl"];
    return [NSDictionary dictionaryWithObjects:valueArray forKeys:keyArray];
}

+(NSDictionary *)MoodShareMapping{
  return @{@"commentNum":@"numberOfComment"
    ,@"content":@"newsBody"
    ,@"id":@"theId"
    ,@"picUrl":@"picUrl"
    ,@"time":@"timeAndDate"
    ,@"userId":@"userId"
    ,@"userName":@"titleBody"
           };

}

+(NSDictionary*)PartyNoticeMapping{
    NSArray *keyArray=@[@"chakan"
                        ,@"comform"
                        ,@"commentNum"
                        ,@"content"
                        ,@"id"
                        ,@"shoucang"
                        ,@"time"
                        ,@"title"
                        ,@"transnum"
                        ,@"userId"
                        ,@"userName"
                        ];
    NSArray *valueArray=@[
                          @"chakan"
                          ,@"comform"
                          ,@"numberOfComment"
                          ,@"newsBody"
                          ,@"theId"
                          ,@"shoucang"
                          ,@"timeAndDate"
                          ,@"titleBody"
                          ,@"transnum"
                          ,@"userId"
                          ,@"userName"
                          ];
    return [[NSDictionary alloc]initWithObjects:valueArray forKeys:keyArray];
}

+(NSDictionary*)PublicityMapping{
    return [self PartyNoticeMapping];
}

+(NSDictionary*)PartyActivityMapping{
    NSArray *keyArray=@[
                        @"branch"
                        ,@"commentNum"
                        ,@"content"
                        ,@"count"
                        ,@"id"
                        ,@"institute"
                        ,@"love"
                        ,@"picUrl"
                        ,@"signUp"
                        ,@"time"
                        ,@"title"
                        ,@"top"
                        ,@"userId"
                        ,@"userName"
                        ,@"zipPicUrl"
                        ];
    NSArray *valueArray=@[
                          @"branch"
                          ,@"numberOfComment"
                          ,@"newsBody"
                          ,@"count"
                          ,@"theId"
                          ,@"institute"
                          ,@"love"
                          ,@"picUrl"
                          ,@"signUp"
                          ,@"timeAndDate"
                          ,@"titleBody"
                          ,@"top"
                          ,@"userId"
                          ,@"userName"
                          ,@"zipPicUrl"
                          ];
    return [[NSDictionary alloc]initWithObjects:valueArray forKeys:keyArray];
}


@end
