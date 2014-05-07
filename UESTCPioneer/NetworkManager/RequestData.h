//
//  RequestData.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-29.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestData : NSObject
/**
 001 通信与信息工程学院 011 经济与管理学院
 002
 电子工程学院
 012
 政治与公共管理学院
 003
 微电子与固体电子学院
 013
 外国语学院
 004
 物理电子学院
 016
 马克思主义教育学院
 005
 光电信息学院
 017
 能源科学与工程学院
 006
 计算机科学与工程学院
 022
 信息与软件工程学院
 007
 自动化工程学院
 024
 电子科学技术研究院
 008
 机械电子工程学院
 025
 空天科学技术研究院
 009
 生命科学与技术学院
 026
 通信抗干扰技术国家级重点实验室
 010
 数学科学学院
 027
 东莞电子信息工程研究院
 */
+(NSDictionary*)CollegeRequestDataWithCode:(NSString*)collegeCodeString;

+(NSDictionary*)AllNewsRequestData;

+(NSDictionary*)NoticeDataWithLevel:(NSInteger)level;

+(NSDictionary*)ActivityDataWithTypeName:(NSString*)type;




//以下是个人管理模块的数据请求 张众
+ (NSDictionary *)sendBirthCareRequestDataWithForuserid:(NSUInteger)foruserid;//生日关怀送祝福

+ (NSDictionary *)getListOfBirthRequestDataWithPage:(NSUInteger)page;//得到过生日的列表

+ (NSDictionary *)sendNoticeRequestDataWithContent:(NSString *)content;//发布通知

+ (NSDictionary *)startActivityRequestDataWithContent:(NSString *)content title:(NSString *)title;//发起活动

+ (NSDictionary *)getDailyCareRequestDataWithPage:(NSUInteger)page;//得到日常关怀列表

+ (NSDictionary *)sendDailyCareRequestDataWithContent:(NSString *)content;//发布日常关怀

+ (NSDictionary *)getCollectionRequestDataWithPage:(NSUInteger)page;//得到收藏列表

+ (NSDictionary *)getListOfMessageRequestDataWithPage:(NSUInteger)page;//得到我的消息列表

+ (NSDictionary *)getSpecialMessageRequestDataWithMsgid:(NSUInteger)msgid;//得到我的消息内容

+ (NSDictionary *)getListOfNoticeRequestDataWithPage:(NSUInteger)page;//得到我的通知列表

+ (NSDictionary *)getListOfAnnounceRequestDataWithPage:(NSUInteger)page;//得到查看意见列表

+ (NSDictionary *)getAnnounceContentRequestDataWithAnnounceid:(NSUInteger)announceid;//得到查看意见点进去的内容

+ (NSDictionary *)getAnnnounceProposalRequestDataWithAnnounceid:(NSUInteger)announceid page:(NSUInteger)page;//得到发布的意见

+ (NSDictionary *)getPerAdminNoticeRequestDataWithNoticeid:(NSUInteger)noticeid;//进入我的收藏和我的通知之后，获取具体的内容

+ (NSDictionary *)changePersonalInformationRequestDataWithNickname:(NSString *)Nickname withName:(NSString *)name withSex:(NSString *)sex withNation:(NSString *)nation withHometown:(NSString *)hometown withOldPassword:(NSString *)oldpassword withNewPassword:(NSString *)newpassword;//修改个人信息

@end
