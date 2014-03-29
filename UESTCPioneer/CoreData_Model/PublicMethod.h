//
//  PublicMethod.h
//  UESTCPioneer
//
//  Created by viking warlock on 3/8/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserEntity.h"
#import "NewsEntity.h"

@interface PublicMethod : NSObject


///清空某实体
+(void)ClearEntity:(NSString *)entityName;

///某实体数量
+(NSInteger)NumberOfEntity:(NSString*)entityName;

//某实体数组
+(NSArray*)EntityArrayWithEntityName:(NSString*)entityName;

//CoreData 中储存的用户的数量
+(NSInteger)NumberOfUsers;

//CoreData 中储存的新闻的数量
+(NSInteger)NumberOfNewses;

//更新CoreData 静态列表
+(void)refreshStaticCoreData;

//根据用户的名字查找特定的用户实例
+(UserEntity*)UserInformationWithUserName:(NSString*)username;

//fetch全部新闻实例，
//return NSArray
+(NSArray*)NewsArray_AllFromCoreData;

//fetch部分新闻实例
//location起始位置 , length为获取的长度
//return NSArray
+(NSArray*)NewsArray_PartFromCoreDataWithRange:(NSInteger)location AndLength:(NSInteger)length;

//获取某一个序号的新闻实例
+(NewsEntity*)NewsForIndexNumber:(NSInteger)index;

//根据关键字获取新闻列表
//@example: keywords=@"canJoin" content=@1 means 搜索所有可以参加活动的新闻
//return NSArray
+(NSArray*)NewsForKeyWords:(NSString*)keywords AndContent :(id)content;

//暂时不用
+(void)PushToSaveQueue:(id)content;

//保存所有为保存的数据
+(void)DataSave;

//清除某个实例
//@example
// UserEntity *a=[PublicMethod NewsForIdexNumber:1];
// [PublicMethod DeleteEntity:a];
//从 CoreDate中删除当前序号为1的新闻

+(void)DeleteEntity:(NSObject*)object;

//清除CoreData的所有数据
+(void)ClearAllCoreData;

//清除下载的缓存文件
//including: images ,caches,plist,documents...
+(void)ClearDownloadedFile;



@end
