//
//  RequestData.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-29.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "RequestData.h"


/*
 001
 通信与信息工程学院
 011
 经济与管理学院
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

@implementation RequestData

//分院请求数据
+(NSDictionary*)CollegeRequestDataWithCode:(NSString*)collegeCodeString{
    return @{@"type":@"getYuanNews",@"yuanCode":collegeCodeString,@"page":@"1"};
}

//“全部”新闻请求数据
+(NSDictionary*)AllNewsRequestData{
  return @{@"type":@"getNews",@"page":@"1"};
}


///level:为0，1、2、3分别代表校级通知、院级、支部、全部通知；
+(NSDictionary*)NoticeDataWithLevel:(NSInteger)level{
        return @{@"type":@"getNoticeOrAnnounce"
                  ,@"userId":[constant getUserId]
                  ,@"userName":[constant getUserName]
                  ,@"page":@"1"
                  ,@"typepid":@"1"
                  ,@"level":[NSString stringWithFormat:@"%d",level]};
}

+(NSDictionary*)ActivityDataWithTypeName:(NSString*)type{
    if ([type isEqualToString:@"最新"])
    return @{@"type":@"getEvent",@"userId":[constant getUserId],@"page":@"1"};
    else if ([type isEqualToString:@"热门"])
        return @{@"type":@"sortEvent",@"userId":[constant getUserId],@"page":@"1"};
    return  nil;
}




//个人管理模块请求数据
+ (NSDictionary *)sendBirthCareRequestDataWithForuserid:(NSUInteger)foruserid
{
    return @{
             @"type":@"lifecareBless",
             @"userId":[constant getUserId],
             @"typepid":@"sendbless",
             @"userName":[constant getUserName],
             @"foruserid":[NSString stringWithFormat:@"%D",foruserid]
             };
}

+ (NSDictionary *)getListOfBirthRequestDataWithPage:(NSUInteger)page
{
    return @{
             @"type":@"lifecareBless",
             @"userId":[constant getUserId],
             @"typepid":@"blesslist",
             @"page":[NSString stringWithFormat:@"%d",page],
             };
}

+ (NSDictionary *)sendNoticeRequestDataWithContent:(NSString *)content
{
    return @{
             @"type":@"writeNoticeOrAnnounce",
             @"typepid":@"1",
             @"userId":[constant getUserId],
             @"userName":[constant getUserName],
             @"content":content,
             };
}

+ (NSDictionary *)startActivityRequestDataWithContent:(NSString *)content title:(NSString *)title
{
    return @{
             @"type":@"EventPublish",
             @"userName":[constant getUserName],
             @"userId":[constant getUserId],
             @"content":content,
             @"eventTitle":title
             };
}

+ (NSDictionary *)getDailyCareRequestDataWithPage:(NSUInteger)page
{
    return @{
             @"type":@"lifecareBless",
             @"typepid":@"lifecarelist",
             @"userId":[constant getUserId],
             @"page":[NSString stringWithFormat:@"%d",page],
             };
}

+ (NSDictionary *)sendDailyCareRequestDataWithContent:(NSString *)content
{
    return @{
             @"type":@"lifecareBless",
             @"typepid":@"sendlifecare",
             @"userId":[constant getUserId],
             @"userName":[constant getUserName],
             @"content":content,
             };
}

+ (NSDictionary *)getCollectionRequestDataWithPage:(NSUInteger)page;
{
    return @{
             @"type":@"perAdminNotice",
             @"typepid":@"1",
             @"userId":[constant getUserId],
             @"page":[NSString stringWithFormat:@"%d",page],
             };
}

+ (NSDictionary *)getListOfMessageRequestDataWithPage:(NSUInteger)page
{
    return @{
             @"type":@"msgRemind",
             @"userId":[constant getUserId],
             @"page":[NSString stringWithFormat:@"%d",page],
             };
}

+ (NSDictionary *)getSpecialMessageRequestDataWithMsgid:(NSUInteger)msgid
{
    return @{
             @"type":@"msgRemind",
             @"userId":[constant getUserId],
             @"typepid":@"bless",
             @"id":[NSString stringWithFormat:@"%d",msgid],
             };
}

+ (NSDictionary *)getListOfNoticeRequestDataWithPage:(NSUInteger)page
{
    return @{
             @"type":@"perAdminNotice",
             @"typepid":@"0",
             @"userId":[constant getUserId],
             @"page":[NSString stringWithFormat:@"%d",page],
             };
}

+ (NSDictionary *)getListOfAnnounceRequestDataWithPage:(NSUInteger)page
{
    return @{
             @"type":@"perAdminAnnounce",
             @"typepid":@"getAnnnouncelist",
             @"userId":[constant getUserId],
             @"page":[NSString stringWithFormat:@"%d",page],
             };
}

+ (NSDictionary *)getAnnounceContentRequestDataWithAnnounceid:(NSUInteger)announceid
{
    return @{
             @"type":@"perAdminNotice",
             @"noticeid":[NSString stringWithFormat:@"%d",announceid],
             };
}

+ (NSDictionary *)getAnnnounceProposalRequestDataWithAnnounceid:(NSUInteger)announceid page:(NSUInteger)page
{
    return @{
             @"type":@"perAdminAnnounce",
             @"typepid":@"getAnnnounceProposal",
             @"userId":[constant getUserId],
             @"announceid":[NSString stringWithFormat:@"%d",announceid],
             @"page":[NSString stringWithFormat:@"%d",page],
             };
}

+ (NSDictionary *)getPerAdminNoticeRequestDataWithNoticeid:(NSUInteger)noticeid
{
    return @{
             @"type":@"perAdminNotice",
             @"noticeid":[NSString stringWithFormat:@"%d",noticeid],
             };
}

+ (NSDictionary *)changePersonalInformationRequestDataWithNickname:(NSString *)Nickname withName:(NSString *)name withSex:(NSString *)sex withNation:(NSString *)nation withHometown:(NSString *)hometown withOldPassword:(NSString *)oldpassword withNewPassword:(NSString *)newpassword
{
    return @{
             @"id":[constant getUserId],
             @"oldPwd":oldpassword,
             @"name":name,
             @"nation":nation,
             @"hometown":hometown,
             @"newPwd":newpassword,
             @"sex":sex,
             @"userName":Nickname,
             };
}

@end
