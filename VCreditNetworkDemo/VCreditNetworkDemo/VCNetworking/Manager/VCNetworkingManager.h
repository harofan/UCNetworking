//
//  VCNetworkingManager.h
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


@class VCNetworkingManager;
@class VCResponsobjParser;

@protocol VCNetworkingManagerDelegate<NSObject>

@optional
- (void)networingManager:(VCNetworkingManager *)manager statusChanged:(AFNetworkReachabilityStatus)status;
- (BOOL)networingManager:(VCNetworkingManager *)manager filterResponse:(NSDictionary *)dic error:(NSError *)error;
- (BOOL)networingManager:(VCNetworkingManager *)manager filterRetryFailureSessionManager:(AFHTTPSessionManager *)sessionManager error:(NSError *)error;

@end

@interface VCNetworkingManager : NSObject

@property (nonatomic, weak) id <VCNetworkingManagerDelegate>delegate;

@property (nonatomic,strong) VCResponsobjParser *parser;

/**
 AFN manager
 */
@property (nonatomic, strong, readonly) AFHTTPSessionManager *manager;

#pragma mark construct manager
+ (instancetype)shareManager;

#pragma mark POST
- (void)postUrl:(NSString *) url;
- (void)postUrl:(NSString *) url completion:(void(^)(id)) completion;
- (void)postUrl:(NSString *) url class:(Class)classObj completion:(void(^)(id)) completion;
- (void)postUrl:(NSString *) url params:(NSDictionary *)params class:(Class)classObj completion:(void(^)(id)) completion;
- (void)postUrl:(NSString *)url params:(NSDictionary *)params class:(Class )classObj completion:(void (^)(id))completion error : (void (^)(NSError *))failure;
- (void)postUrl:(NSString *)url params:(NSDictionary *)params class:(Class )classObj completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))failure;

#pragma mark POST IMAGE
- (void)postUrl:(NSString *)url images:(NSArray *)imgArray imageFilePathStr:(NSString *)imageFilePathStr progress:(void (^)(NSProgress *  ))progressCallBack completion : (void (^)(id))completion;
- (void)postUrl:(NSString *)url images:(NSArray *)imgArray params:(NSDictionary *)params imageFilePathStr:(NSString *)imageFilePathStr class:(Class )classObj progress:(void (^)(NSProgress *  ))progressCallBack completion : (void (^)(id))completion;
- (void)postUrl:(NSString *)url images:(NSArray *)imgArray params:(NSDictionary *)params imageFilePathStr:(NSString *)imageFilePathStr class:(Class )classObj progress:(void (^)(NSProgress *  ))progressCallBack completion : (void (^)(id))completion  error : (void (^)(NSError *))failure;
- (void)postUrl:(NSString *)url images:(NSArray *)imgArray params:(NSDictionary *)params imageFilePathStr:(NSString *)imageFilePathStr class:(Class )classObj progress:(void (^)(NSProgress *  ))progressCallBack completion : (void (^)(id))completion exceptions:(void (^)(id))exceptions error : (void (^)(NSError *))failure;

#pragma mark GET
- (void)getUrl:(NSString *) url;
- (void)getUrl:(NSString *) url class:(Class)classVc completion:(void(^)(id)) completion;
- (void)getUrl:(NSString *) url params:(NSDictionary *)params class:(Class)classVc completion:(void(^)(id)) completion;
- (void)getUrl:(NSString *)url params:(NSDictionary *)params class:(Class )cls completion : (void (^)(id))completion  error : (void (^)(NSError *))failure;
- (void)getUrl:(NSString *)url params:(NSDictionary *)params class:(Class )cls completion : (void (^)(id))completion exceptions:(void (^)(id))exceptions error : (void (^)(NSError *))failure;

#pragma mark HTTP Header
/**
 set token
 */
- (void)setRequestHeaderField:(NSString *)accessToken;
@end
