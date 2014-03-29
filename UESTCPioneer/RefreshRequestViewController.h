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
    
@protected
    //各控制器的请求数据
    NSDictionary *requestData;
    NSString *entityName;
    NSDictionary *entityMapping;
    
    ///请求评论列表的
    NSDictionary *commentListRequestData;
    ///请求提交评论
    NSDictionary *commentWriteRequestData;
    ///请求中表示Id的键，每个请求都不一样
    NSString *commentIdKey;
    ///
    NSString *commentWriteIdKey;
    
    
    ///请求中评论内容的键，每个请求都不一样
    NSString *commentContentKey;
    ///评论请求列表的映射关系(评论界面是统一的，但每个评论返回数据的键不统一)
    NSDictionary* commentListKeyMapping;
    

}
-(void)_initRequestRequireEntityName:(NSString*)EntityName EntityMapping:(NSDictionary*)EntityMapping RequestData:(NSDictionary*)RequestData CommentListRequestData:(NSDictionary*)CommentListRequestData CommentWriteRequestData:(NSDictionary*)CommentWriteRequestData CommentIdKey:(NSString*)CommentIdKey CommentContentKey:(NSString*)CommentContentKey CommentListKeyMapping:(NSDictionary*)CommentListKeyMapping;
-(void)commentButtonPress:(commentButton*)button;
@end
