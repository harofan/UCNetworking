//
//  UCNetworkingManager.h
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UCNetworkingEnum.h"

@class UCNetworkingManager;

@protocol UCNetworkingManagerDelegate<NSObject>

@optional
- (void)networingManager:(UCNetworkingManager *)manager statusChanged:(AFNetworkReachabilityStatus)status;
//- (BOOL)networingManager:(UCNetworkingManager *)manager filterResponse:(NSDictionary *)dic error:(NSError *)error;
//- (BOOL)networingManager:(UCNetworkingManager *)manager filterRetryFailureSessionManager:(AFHTTPSessionManager *)sessionManager error:(NSError *)error;

@end

@interface UCNetworkingManager : NSObject
#pragma mark construct manager
+ (instancetype)shareManager;

#pragma mark POST
- (NSURLSessionDataTask *)postUrl:(NSString *)url;
- (NSURLSessionDataTask *)postUrl:(NSString *)url
     completion:(void(^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion;
- (NSURLSessionDataTask *)postUrl:(NSString *)url
         params:(NSDictionary *)params
     completion:(void(^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion;
- (NSURLSessionDataTask *)postUrl:(NSString *)url
         params:(NSDictionary *)params
     completion:(void(^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion
        failure:(void (^)(NSError *error))failure;


#pragma mark POST CACHE
- (NSURLSessionDataTask *)postUrl:(NSString *)url
       cacheUrl:(NSString *)cacheUrl
         params:(NSDictionary *)params
     completion:(void(^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion
        failure:(void(^)(NSError *error))failure
cacheDictCallBackBlock:(void(^)(NSDictionary *cacheDict))cacheDictCallBackBlock;

#pragma mark GET
- (NSURLSessionDataTask *)getUrl:(NSString *)url;
- (NSURLSessionDataTask *)getUrl:(NSString *)url
    completion:(void(^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion;
- (NSURLSessionDataTask *)getUrl:(NSString *)url
        params:(NSDictionary *)params
    completion:(void(^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion;
- (NSURLSessionDataTask *)getUrl:(NSString *)url
        params:(NSDictionary *)params
    completion:(void(^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion
         error:(void(^)(NSError *error))failure;

#pragma mark - GET with cache
- (NSURLSessionDataTask *)getUrl:(NSString *)url
      cacheUrl:(NSString *)cacheUrl
        params:(NSDictionary *)params
    completion:(void (^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion
       failure:(void (^)(NSError *error))failure
cacheDictCallBackBlock:(void (^)(NSDictionary *cacheDict))cacheDictCallBackBlock;

#pragma mark - cancel request
- (void)cancelAllRequest;
- (void)cancelRequestWithTask:(NSURLSessionDataTask *)task;

#pragma mark - delegate
- (void)addObjToDelegateArray:(id<UCNetworkingManagerDelegate>)delegateObj;

/**
 Not necessary to use it.
 */
- (void)removeObjFromDelegateArray:(id<UCNetworkingManagerDelegate>)delegateObj;

#pragma mark HTTP Header
- (void)setRequestHeaderFieldWithToken:(NSString *)accessToken;
- (void)setRequestHTTPHeadFieldWithDictionary:(NSDictionary *)dict;
- (void)removeTokenFromHeaderField;
- (void)removeValueFromHeaderFieldWithKey:(NSString *)keyStr;


//#pragma mark POST IMAGE
//- (void)postUrl:(NSString *)url
//         images:(NSArray *)imgArray
//imageFilePathStr:(NSString *)imageFilePathStr
//       progress:(void(^)(NSProgress *))progressCallBack
//     completion:(void (^)(id))completion;
//- (void)postUrl:(NSString *)url
//         images:(NSArray *)imgArray
//         params:(NSDictionary *)params
//imageFilePathStr:(NSString *)imageFilePathStr
//          class:(Class)classObj
//       progress:(void(^)(NSProgress *))progressCallBack
//     completion:(void (^)(id))completion;
//- (void)postUrl:(NSString *)url
//         images:(NSArray *)imgArray
//         params:(NSDictionary *)params
//imageFilePathStr:(NSString *)imageFilePathStr
//          class:(Class)classObj
//       progress:(void(^)(NSProgress *))progressCallBack
//     completion:(void(^)(id))completion
//          error:(void(^)(NSError *))failure;
//- (void)postUrl:(NSString *)url
//         images:(NSArray *)imgArray
//         params:(NSDictionary *)params
//imageFilePathStr:(NSString *)imageFilePathStr
//          class:(Class)classObj
//       progress:(void(^)(NSProgress *))progressCallBack
//     completion:(void(^)(id))completion
//     exceptions:(void(^)(id))exceptions
//          error:(void(^)(NSError *))failure;
//

@end
