//
//  Mapping.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-28.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mapping : NSObject
+(NSDictionary*)PioneerMapping;
+(NSDictionary *)MoodShareMapping;

+(NSDictionary*)PartyNoticeMapping;
+(NSDictionary*)PublicityMapping;
+(NSDictionary*)PartyActivityMapping;

+(NSDictionary*)partiesMapping;


+ (NSDictionary *)personalBirthMapping;
@end
