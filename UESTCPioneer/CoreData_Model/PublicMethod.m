//
//  PublicMethod.m
//  UESTCPioneer
//
//  Created by viking warlock on 3/8/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "PublicMethod.h"
#import "MoodShareNewsEntity.h"

static id CoreDataQueue;
static id NewsQueue;
static id UserQueue;

@interface PublicMethod()
{

}
@end

@implementation PublicMethod


+(NSInteger)NumberOfEntity:(NSString*)entityName{
    return [NSClassFromString(entityName) MR_countOfEntities];
}

+(NSInteger)NumberOfUsers
{
    return [UserEntity MR_countOfEntities];
}

+(NSInteger)NumberOfNewses
{
    return [NewsEntity MR_countOfEntities];
}

+(void)refreshStaticCoreData
{
    if ([NewsQueue count]<[PublicMethod NumberOfNewses]) {
        NewsQueue=[NewsEntity MR_findAllSortedBy:@"timeAndDate" ascending:YES];
    }
    
    if ([UserQueue count]<[PublicMethod NumberOfUsers]) {
        UserQueue=[UserEntity MR_findAllSortedBy:@"userID" ascending:YES];
    }
    
}



+(UserEntity*)UserInformationWithUserName:(NSString*)username
{
    return [UserEntity MR_findFirstByAttribute:@"userName" withValue:username];
    
}

+(id)entity:(NSString*)entityName WithId:(NSInteger)theId{
    return [NSClassFromString(entityName) MR_findFirstByAttribute:@"theId" withValue:@(theId)];
}

+(NSArray*)EntityArrayWithEntityName:(NSString*)entityName{
    
    return [NSClassFromString(entityName) MR_findAllSortedBy:@"theId" ascending:NO];
}


+(NSArray*)NewsArray_AllFromCoreData
{
    [PublicMethod refreshStaticCoreData];
    return NewsQueue;
}

+(NSArray*)NewsArray_PartFromCoreDataWithRange:(NSInteger)location AndLength:(NSInteger)length
{
    [PublicMethod refreshStaticCoreData];
    NSRange range;
    range.location=location;
    range.length=length;
    
    NSArray *result=[NewsQueue objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    
    
    return result;
    
}

+(NewsEntity*)NewsForIndexNumber:(NSInteger)index
{
    [PublicMethod refreshStaticCoreData];
    return [NewsQueue objectAtIndex:index];
}

+(NSArray*)NewsForKeyWords:(NSString*)keywords AndContent :(id)content
{
    return [NewsEntity MR_findByAttribute:keywords withValue:content andOrderBy:@"timeAndDate" ascending:YES];
}


+(void)PushToSaveQueue:(id)content
{
    if ([content isKindOfClass:NewsQueue]) {
        
    }else
        if ([content isKindOfClass:UserQueue]) {
            
        }
    
}

+(void)DataSave
{
    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
    
}

+(void)DeleteEntity:(NSObject *)object
{
    //clear queue first
    
    
    
}

+(void)ClearEntity:(NSString *)entityName{
    [NSClassFromString(entityName) MR_truncateAll];
}

+(void)ClearAllCoreData
{
    
    CoreDataQueue=nil;
    [UserEntity MR_truncateAll];
    [NewsEntity MR_truncateAll];
//    [MoodShareNewsEntity MR_truncateAll];
}


@end
