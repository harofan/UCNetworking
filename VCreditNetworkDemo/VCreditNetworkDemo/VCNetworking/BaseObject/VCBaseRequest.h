//
//  VCBaseRequest.h
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
//#import "VCResponsobjParser.h"

typedef NS_ENUM(NSInteger, VCNetworkRequestType) {
    VCNetworkRequestPostType = 0,
    VCNetworkRequestGetType,
    VCNetworkRequestDownloadType,
    VCNetworkRequestUploadType,
    VCNetworkRequestUploadImageType,
};

typedef NS_ENUM(NSInteger, VCHttpMethodType) {
    VCPostHttpType = 0,
    VCGetHttpType,
};


@interface VCBaseRequest : NSObject

/**
 request url
 */
@property (nonatomic, strong, readonly) NSString *urlStr;

/**
 request parame
 */
@property (nonatomic, copy, readonly) NSDictionary<NSString *, NSString *> *parameters;

/**
 default is NetworkRequestTypeData
 */
@property (nonatomic, assign, readonly) VCNetworkRequestType requestType;

/**
 GET or POST request
 */
@property (nonatomic, assign, readonly) VCHttpMethodType HTTPMethod;

/**
 request header.You can add accesstoken here.
 */
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> *HTTPHeader;

/**
 default is 18.0s
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 YYmodel processing data 
 */
//@property (nonatomic, strong, readonly) VCResponsobjParser *parser;


/**
 post && normal request method
 */
- (instancetype)initWithUrlStr:(NSString *)urlStr parameters:(NSDictionary<NSString *, NSString *> *)parameters;

/**
 construct method
 */
- (instancetype)initWithRequestType:(VCNetworkRequestType)requestType HTTPMethod:(VCHttpMethodType)HTTPMethod urlStr:(NSString *)urlStr parameters:(NSDictionary<NSString *, NSString *> *)parameters;


@end
