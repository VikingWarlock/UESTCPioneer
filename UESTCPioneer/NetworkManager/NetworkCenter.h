//
//  NetworkCenter.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-16.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkCenter : NSObject

/**
 Restkit 的GET请求，通过将请求的数据直接映射倒Core Data里
 @param data:请求参数如@{@"type":@"getNews",@"page":"1"}
 @param entity:实体名称如@“UserEntity”，具体请参考邢旻罡创建的CoreData文件夹里的文件
 @param mapping:映射字典，例如json是：{"newsName":"xxxxx","newsBody":"xxxx"}，实体里对应属性为title和text则mapping为@{"newsName":"title",@"newsBody",@"text"}
 @param successBlock:请求成功后返回调用的回调
 @param failureBLock:请求失败后的回调
 */
+(void)RKRequestWithData:(NSDictionary*)data  EntityName:(NSString*)entity Mapping:(NSDictionary*)mapping  SuccessBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock;

///带keyPath参数
+(void)RKRequestWithData:(NSDictionary*)data  EntityName:(NSString*)entity Mapping:(NSDictionary*)mapping KeyPath:(NSString*)keyPath  SuccessBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock;
/*
 [NetworkCenter AFRequestWithData:dictionary SuccessBlock:^(AFHTTPRequestOperation *operation,id resultObject){
 NSLog(@"请求成功");
 NSLog(@"结果是：%@",resultObject);
 } FailureBlock:^(AFHTTPRequestOperation *opration,NSError *error){
 NSLog(@"请求失败");
 NSLog(@"错误信息%@",error);
 }];
 */


/**
 AFNetworking的GET请求 ，返回Json数据
 @param data 请求参数如@{@"type":@"getNews",@"page":"1"}
 @param successBlock:请求成功后返回调用的回调
 @param failureBLock:请求失败后的回调
 */
+(void)AFRequestWithData:(NSDictionary*)data SuccessBlock:(void (^)(AFHTTPRequestOperation *operation,id resultObject))successBlock FailureBlock:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock;
@end
