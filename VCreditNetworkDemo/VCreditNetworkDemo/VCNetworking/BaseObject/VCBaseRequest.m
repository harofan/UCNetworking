//
//  VCBaseRequest.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCBaseRequest.h"
#import "VCPostRequest.h"
#import "VCGetRequest.h"
#import "VCDownloadRequest.h"
#import "VCUploadRequest.h"
#import "VCNetworkingManager.h"
#import "VCUploadImageRequest.h"


@interface VCBaseRequest ()

/**
 request url
 */
@property (nonatomic, strong, readwrite) NSString *urlStr;

/**
 request parame
 */
@property (nonatomic, copy, readwrite) NSDictionary<NSString *, NSString *> *parameters;

/**
 default is NetworkRequestTypeData
 */
@property (nonatomic, assign, readwrite) VCNetworkRequestType requestType;

/**
 GET or POST request
 */
@property (nonatomic, assign, readwrite) VCHttpMethodType HTTPMethod;


@end

@implementation VCBaseRequest

#pragma mark init method
/**
 post && normal request method
 */
- (instancetype)initWithUrlStr:(NSString *)urlStr parameters:(NSDictionary<NSString *,NSString *> *)parameters{
    
    return [self initWithRequestType:VCNetworkRequestPostType HTTPMethod:VCPostHttpType urlStr:urlStr parameters:parameters];
}

/**
 construct method
 */
- (instancetype)initWithRequestType:(VCNetworkRequestType)requestType HTTPMethod:(VCHttpMethodType)HTTPMethod urlStr:(NSString *)urlStr parameters:(NSDictionary<NSString *,NSString *> *)parameters{
    
    if (self = [super init]) {
//        _requestType = requestType;
//        _HTTPMethod = HTTPMethod;
//        _urlStr = urlStr;
//        _parameters = parameters;
        
        //set timeout.If you do not need to set the timeout for each request, you can set the manage class uniformly.
        [self p_setTimeOutInterval:18.f];
        
        //Create a request.
        VCBaseRequest *baseRequest = [self p_createRequestWithRequestType:requestType];
        baseRequest.urlStr = urlStr;
        baseRequest.parameters = parameters;
        return baseRequest;
    }
    return self;
}

#pragma mark private
/**
 Create a request based on your parameters.If there is an exception created VCNormalRequest.
 */
- (instancetype)p_createRequestWithRequestType:(VCNetworkRequestType)requestType{
    
    switch (requestType) {
        case VCNetworkRequestPostType:
        {
            return [VCPostRequest new];
        }
            break;
            
        case VCNetworkRequestGetType:
        {
            return [VCGetRequest new];
        }
            break;
            
        case VCNetworkRequestUploadType:
        {
            return [VCUploadRequest new];
        }
            break;
            
        case VCNetworkRequestDownloadType:
        {
            return [VCDownloadRequest new];
        }
            break;
            
        case VCNetworkRequestUploadImageType:
        {
            return [VCUploadImageRequest new];
        }
            break;
    }
    return [VCPostRequest new];
}

- (void)p_setTimeOutInterval:(CGFloat)timeoutInterval{
    
    AFHTTPSessionManager *manager = [VCNetworkingManager shareManager].manager;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setTimeoutInterval:timeoutInterval];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
}

#pragma mark  set && get
- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval{
    _timeoutInterval = timeoutInterval;
    [self p_setTimeOutInterval:timeoutInterval];
}

@end
