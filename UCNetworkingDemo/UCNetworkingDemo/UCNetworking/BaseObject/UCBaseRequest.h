//
//  BaseRequest.h
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCNetworkingEnum.h"
#import <AFNetworking.h>

@interface UCBaseRequest : NSObject

/**
 request url
 */
@property (nonatomic, copy) NSString *urlStr;

/**
 request parame
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *parameters;

@property (strong, nonatomic) AFHTTPSessionManager *httpManager;

@property (nonatomic, assign, readonly) UCAPIManagerRequestType requestType;

- (instancetype)initPostRequestWithUrlStr:(NSString *)urlStr
                    parameters:(NSDictionary<NSString *,NSString *> *)parameters;
- (instancetype)initWithUrlStr:(NSString *)urlStr
                   requestType:(UCAPIManagerRequestType)requestType
                    parameters:(NSDictionary<NSString *,NSString *> *)parameters;

/**
 subClass override these method.
 */
- (NSURLSessionDataTask *)startRequestWithSuccessCallBack:(void (^)(NSDictionary *responseDict))successCallBack
                        failureCallBack:(void (^)(NSError *error))failureCallBack;
- (NSURLSessionDataTask *)startRequestWithCacheCallBack:(void (^)(NSDictionary *cacheDict))cacheCallBack
                      SuccessCallBack:(void (^)(NSDictionary *responseDict))successCallBack
                        failureCallBack:(void (^)(NSError *error))failureCallBack;
@end
