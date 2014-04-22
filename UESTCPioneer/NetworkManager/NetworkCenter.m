//
//  NetworkCenter.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-16.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "NetworkCenter.h"




#define mappingPioneer @{}//成电先锋
#define mappingPartyNotice//党委通知
#define mappingPublicity //公示公告
#define mappingPartyActivity //组织活动
#define mappingMoodShare //心情分享


//default
#define kDefaultTimeInterval 3


@implementation NetworkCenter


#pragma mark - mapping function


#pragma mark - 详细的请求





#pragma mark - NFNetworking 


/*
 lastPattern 指例子中的ieaction.do
 例子： UestcApp/ieaction.do"
 */
+(void)AFRequestWithLastPattern:(NSString*)lastPattern Data:(NSDictionary*)data SuccessBlock:(void (^)(AFHTTPRequestOperation *operation,id resultObject))successBlock FailureBlock:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock{
    
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL  URLWithString:baseUrl]];
    [client getPath:[[baseUrl stringByAppendingString:appPattern ] stringByAppendingString:lastPattern] parameters:data success:^(AFHTTPRequestOperation *operation,id resultObject){
        successBlock(operation,resultObject);
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        failureBlock(operation,error);
        
    }];
    
    
    
}



+(void)AFRequestWithData:(NSDictionary*)data SuccessBlock:(void (^)(AFHTTPRequestOperation *operation,id resultObject))successBlock FailureBlock:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock{
    
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL  URLWithString:baseUrl]];
    [client getPath:tempPattern parameters:data success:^(AFHTTPRequestOperation *operation,id resultObject){
        successBlock(operation,resultObject);
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        failureBlock(operation,error);
        
    }];
    


}

+(void)AFRequestWithUrlPattern:(NSString*)pattern Data:(NSDictionary*)data SuccessBlock:(void (^)(AFHTTPRequestOperation *operation,id resultObject))successBlock FailureBlock:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL  URLWithString:baseUrl]];
    [client getPath:pattern parameters:data success:^(AFHTTPRequestOperation *operation,id resultObject){
        successBlock(operation,resultObject);
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        failureBlock(operation,error);
        
    }];
}

#pragma mark - restkit request


/*
 lastPattern 指例子中的ieaction.do
例子： UestcApp/ieaction.do"
 */
+(void)RKRequestWithLastPattern:(NSString*)lastPattern Data:(NSDictionary*)data  EntityName:(NSString*)entity Mapping:(NSDictionary*)mapping  SuccessBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock{
    [self requestWithUrlPattern:[[baseUrl stringByAppendingString:appPattern] stringByAppendingString:lastPattern] Data:data EntityName:entity Mapping:mapping SuccessBlock:^(NSArray *resultArray){
        successBlock(resultArray);
    } failure:^(NSError *error){
        failureBlock(error);
    }];
    
}


+(void)RKRequestWithData:(NSDictionary*)data  EntityName:(NSString*)entity Mapping:(NSDictionary*)mapping  SuccessBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock{
    [self requestWithUrlPattern:tempPattern Data:data EntityName:entity Mapping:mapping SuccessBlock:^(NSArray *resultArray){
        successBlock(resultArray);
    } failure:^(NSError *error){
        failureBlock(error);
    }];

}

///with key path
+(void)RKRequestWithData:(NSDictionary*)data  EntityName:(NSString*)entity Mapping:(NSDictionary*)mapping KeyPath:(NSString*)keyPath  SuccessBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock{
    [self requestWithUrlPattern:tempPattern Type:@"GET" Data:data TimeoutInterval:kDefaultTimeInterval EntityName:entity Mapping:mapping KeyPath:keyPath SuccessBlock:^(NSArray *resultArray){
        successBlock(resultArray);
    } failure:^(NSError *error){
        failureBlock(error);
        
    }];
}


+(void)requestWithUrlPattern:(NSString*)pattern Data:(NSDictionary*)data  EntityName:(NSString*)entity Mapping:(NSDictionary*)mapping  SuccessBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock{
    [self requestWithUrlPattern:pattern Type:@"GET" Data:data TimeoutInterval:kDefaultTimeInterval EntityName:entity Mapping:mapping KeyPath:nil SuccessBlock:^(NSArray *resultArray){
        successBlock(resultArray);
    } failure:^(NSError *error){
        failureBlock(error);
    }];
    
}

+(void)requestWithUrlPattern:(NSString*)pattern Type:(NSString*)type Data:(NSDictionary*)data  EntityName:(NSString*)entity Mapping:(NSDictionary*)mapping  SuccessBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock{
    [self requestWithUrlPattern:pattern Type:type Data:data TimeoutInterval:kDefaultTimeInterval EntityName:entity Mapping:mapping KeyPath:nil SuccessBlock:^(NSArray *resultArray){
        successBlock(resultArray);
    } failure:^(NSError *error){
        failureBlock(error);
        
    }];
}



+(void)requestWithUrlPattern:(NSString*)pattern Type:(NSString*)type Data:(NSDictionary*)data  EntityName:(NSString*)entity Mapping:(NSDictionary*)mapping KeyPath:(NSString*)keyPath SuccessBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock{
    [self requestWithUrlPattern:pattern Type:type Data:data TimeoutInterval:kDefaultTimeInterval EntityName:entity Mapping:mapping KeyPath:keyPath SuccessBlock:^(NSArray *resultArray){
        successBlock(resultArray);
    } failure:^(NSError *error){
        failureBlock(error);
    
    }];
}





+(void)requestWithUrlPattern:(NSString*)pattern Type:(NSString*)type Data:(NSDictionary*)data TimeoutInterval:(NSTimeInterval)timeoutInterval EntityName:(NSString*)entity Mapping:(NSDictionary*)mapping KeyPath:(NSString*)keyPath SuccessBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock{
    NSString *baseUrlString=baseUrl;
    RKManagedObjectStore *managedObjectStore=[RKManagedObjectStore defaultStore];
    
    RKEntityMapping *articleMapping = [RKEntityMapping mappingForEntityForName:entity inManagedObjectStore:managedObjectStore];
    [articleMapping addAttributeMappingsFromDictionary:mapping];
    

    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping method:RKRequestMethodAny pathPattern:nil keyPath:keyPath statusCodes:statusCodes];
    
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseUrlString]];
    [request setHTTPMethod:type];
    [request setTimeoutInterval:timeoutInterval];
    //设置Data

    NSString *dataString=[data descriptionInStringsFileFormat];
    //格式化
    dataString=[dataString stringByReplacingOccurrencesOfString:@" " withString:@""];
    dataString=[dataString stringByReplacingOccurrencesOfString:@";" withString:@"&"];
    dataString=[dataString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    dataString=[dataString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    dataString=[dataString substringToIndex:dataString.length-1];
        //如果没有或者输错，默认用get
    if ([[type uppercaseString] isEqualToString:@"POST"]){
        [request setHTTPBody:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
        [request setURL:[NSURL URLWithString:[baseUrlString stringByAppendingString:pattern]]];
    }
    else {
        NSString *patternString=[@"?" stringByAppendingString:dataString];
        
        [request setURL:[NSURL URLWithString:[[baseUrlString stringByAppendingString:pattern] stringByAppendingString:patternString]]];
    }
    
    
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
    RKManagedObjectRequestOperation *operation = [[RKManagedObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    operation.managedObjectContext = managedObjectStore.mainQueueManagedObjectContext;
    operation.managedObjectCache = managedObjectStore.managedObjectCache;
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {

        successBlock([result array]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    [operationQueue addOperation:operation];

}




@end
