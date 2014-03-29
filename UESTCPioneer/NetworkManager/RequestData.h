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

+(NSDictionary*)AllNewsReqeustData;

+(NSDictionary*)NoticeDataWithLevel:(NSInteger)level;

+(NSDictionary*)ActivityDataWithTypeName:(NSString*)type;
@end
