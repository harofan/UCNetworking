//
//  BaseRequest.m
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "UCBaseRequest.h"
#import "UCPostRequest.h"
#import "UCGetRequest.h"

@interface UCBaseRequest()
@property (strong, nonatomic) UCBaseRequest *childRequest;
@end

@implementation UCBaseRequest
#pragma mark - public
- (instancetype)initPostRequestWithUrlStr:(NSString *)urlStr
                               parameters:(NSDictionary<NSString *,NSString *> *)parameters{
    return [self initWithUrlStr:urlStr requestType:UCAPIManagerRequestTypePost parameters:parameters];
}

- (instancetype)initWithUrlStr:(NSString *)urlStr
                   requestType:(UCAPIManagerRequestType)requestType
                    parameters:(NSDictionary<NSString *,NSString *> *)parameters{
    if (self = [super init]) {
        self.childRequest = [self p_createBaseRequestWithRequestType:requestType];
        self.childRequest.urlStr = urlStr;
        self.childRequest.parameters = parameters;
    }
    return self.childRequest;
}

#pragma mark - private
- (UCBaseRequest *)p_createBaseRequestWithRequestType:(UCAPIManagerRequestType)requestType{
    UCBaseRequest *requestObj;
    switch (requestType) {
        case UCAPIManagerRequestTypePost:
            requestObj = [UCPostRequest new];
            break;
            
        case UCAPIManagerRequestTypeGet:
            requestObj = [UCGetRequest new];
            break;
            
    }
    return requestObj;
}
@end
