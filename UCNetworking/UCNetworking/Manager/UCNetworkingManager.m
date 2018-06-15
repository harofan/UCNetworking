//
//  UCNetworkingManager.m
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "UCNetworkingManager.h"
#import "UCNetworkingUrlConfig.h"
#import "UCBaseRequest.h"
#import "UCParser.h"
#import "AFNetworking.h"

@interface UCNetworkingManager ()
@property (nonatomic, strong, readwrite) AFHTTPSessionManager *manager;
@property (copy, nonatomic) NSString *formatUrlStr;
@property (strong, nonatomic) NSHashTable<id<UCNetworkingManagerDelegate>> *delegateHashTable;
@property (assign, nonatomic) BOOL openStatusChangedFlag;
@end

@implementation UCNetworkingManager
#pragma mark construct manager
static UCNetworkingManager *_share = nil;
+ (instancetype)shareManager{
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        _share = [[super allocWithZone:NULL] init];
        _share.openStatusChangedFlag = NO;
    });
    return _share;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self shareManager];
}

#pragma mark - POST
- (NSURLSessionDataTask *)postUrl:(NSString *)url{
    return [self postUrl:url params:nil completion:nil];
}
- (NSURLSessionDataTask *)postUrl:(NSString *)url completion:(void (^)(NSDictionary *, UCAPIManagerResponseStatesType))completion{
    return [self postUrl:url params:nil completion:completion];
}

- (NSURLSessionDataTask *)postUrl:(NSString *)url params:(NSDictionary *)params completion:(void (^)(NSDictionary *, UCAPIManagerResponseStatesType))completion{
    return [self postUrl:url params:params completion:completion failure:nil];
}

- (NSURLSessionDataTask *)postUrl:(NSString *)url params:(NSDictionary *)params completion:(void (^)(NSDictionary *, UCAPIManagerResponseStatesType))completion failure:(void (^)(NSError *))failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.formatUrlStr,url];
    UCBaseRequest *request = [[UCBaseRequest alloc] initPostRequestWithUrlStr:urlStr parameters:params];
    request.httpManager = self.manager;
    return [request startRequestWithSuccessCallBack:^(NSDictionary *responseDict) {
        UCParser *parser = [[UCParser alloc] init];
        [parser successWithResponseDict:responseDict dataParserCallBack:^(NSDictionary *parserDataDict, UCAPIManagerResponseStatesType statesType) {
            if (completion) {
                completion(parserDataDict, statesType);
            }
        }];
    } failureCallBack:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
#pragma mark - POST with cache
- (NSURLSessionDataTask *)postUrl:(NSString *)url
                         cacheUrl:(NSString *)cacheUrl
                           params:(NSDictionary *)params
                       completion:(void (^)(NSDictionary *, UCAPIManagerResponseStatesType))completion
                          failure:(void (^)(NSError *))failure
           cacheDictCallBackBlock:(void (^)(NSDictionary *))cacheDictCallBackBlock{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.formatUrlStr,url];
    UCBaseRequest *request = [[UCBaseRequest alloc] initPostRequestWithUrlStr:urlStr parameters:params];
    request.httpManager = self.manager;
    return [request startRequestWithCacheCallBack:cacheDictCallBackBlock SuccessCallBack:^(NSDictionary *responseDict) {
        UCParser *parser = [[UCParser alloc] init];
        [parser successWithResponseDict:responseDict dataParserCallBack:^(NSDictionary *parserDataDict, UCAPIManagerResponseStatesType statesType) {
            if (completion) {
                completion(parserDataDict, statesType);
            }
        }];
    } failureCallBack:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - GET
- (NSURLSessionDataTask *)getUrl:(NSString *)url{
    return [self getUrl:url completion:nil];
}
- (NSURLSessionDataTask *)getUrl:(NSString *)url
                      completion:(void(^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion{
    return [self getUrl:url params:nil completion:completion];
}
- (NSURLSessionDataTask *)getUrl:(NSString *)url
                          params:(NSDictionary *)params
                      completion:(void(^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion{
    return [self getUrl:url params:params completion:completion error:nil];
}
- (NSURLSessionDataTask *)getUrl:(NSString *)url
                          params:(NSDictionary *)params
                      completion:(void(^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion
                           error:(void(^)(NSError *error))failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.formatUrlStr,url];
    UCBaseRequest *request = [[UCBaseRequest alloc] initWithUrlStr:urlStr requestType:UCAPIManagerRequestTypeGet parameters:params];
    request.httpManager = self.manager;
    return [request startRequestWithSuccessCallBack:^(NSDictionary *responseDict) {
        UCParser *parser = [[UCParser alloc] init];
        [parser successWithResponseDict:responseDict dataParserCallBack:^(NSDictionary *parserDataDict, UCAPIManagerResponseStatesType statesType) {
            if (completion) {
                completion(parserDataDict, statesType);
            }
        }];
    } failureCallBack:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - GET with cache
- (NSURLSessionDataTask *)getUrl:(NSString *)url
                        cacheUrl:(NSString *)cacheUrl
                          params:(NSDictionary *)params
                      completion:(void (^)(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates))completion
                         failure:(void (^)(NSError *error))failure
          cacheDictCallBackBlock:(void (^)(NSDictionary *cacheDict))cacheDictCallBackBlock{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.formatUrlStr,url];
    UCBaseRequest *request = [[UCBaseRequest alloc] initWithUrlStr:urlStr requestType:UCAPIManagerRequestTypeGet parameters:params];
    request.httpManager = self.manager;
    return [request startRequestWithCacheCallBack:cacheDictCallBackBlock SuccessCallBack:^(NSDictionary *responseDict) {
        UCParser *parser = [[UCParser alloc] init];
        [parser successWithResponseDict:responseDict dataParserCallBack:^(NSDictionary *parserDataDict, UCAPIManagerResponseStatesType statesType) {
            if (completion) {
                completion(parserDataDict, statesType);
            }
        }];
    } failureCallBack:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - HTTP Header
- (void)setRequestHeaderFieldWithToken:(NSString *)accessToken{
    NSLog(@"current token:%@",accessToken);
    [self.manager.requestSerializer setValue:accessToken forHTTPHeaderField:@"accessToken"];
}
- (void)setRequestHTTPHeadFieldWithDictionary:(NSDictionary *)dict{
    for (NSString *key in dict.allKeys) {
        [self.manager.requestSerializer setValue:dict[key] forHTTPHeaderField:key];
    }
}
- (void)removeTokenFromHeaderField{
    [self.manager.requestSerializer setValue:@"" forHTTPHeaderField:@"accessToken"];
}

- (void)removeValueFromHeaderFieldWithKey:(NSString *)keyStr{
    [self.manager.requestSerializer setValue:@"" forHTTPHeaderField:keyStr];
}

#pragma mark - add delegate
- (void)addObjToDelegateArray:(id<UCNetworkingManagerDelegate>)delegateObj{
    [self.delegateHashTable addObject:delegateObj];
    
    //open start observing the network status
    if (!self.openStatusChangedFlag &&
        [delegateObj respondsToSelector:@selector(networingManager:statusChanged:)]) {
        [self p_setReachableMonitorOn:YES];
        self.openStatusChangedFlag = YES;
    }
}

- (void)removeObjFromDelegateArray:(id<UCNetworkingManagerDelegate>)delegateObj{
    [self.delegateHashTable removeObject:delegateObj];
}

#pragma mark - cancel request
- (void)cancelAllRequest{
    [self.manager.operationQueue cancelAllOperations];
}
- (void)cancelRequestWithTask:(NSURLSessionDataTask *)task{
    [task cancel];
}
#pragma mark - private
/**
 check net states
 */
- (void)p_setReachableMonitorOn:(BOOL)isOn {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    if (isOn) {
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            UCNetworkReachabilityStatus ucNetworkStatus = (UCNetworkReachabilityStatus)status;
            for (id<UCNetworkingManagerDelegate> delegate in self.delegateHashTable) {
                if (delegate && [delegate respondsToSelector:@selector(networingManager:statusChanged:)]) {
                    [delegate networingManager:self statusChanged:ucNetworkStatus];
                }
            }
        }];
    } else {
        [manager stopMonitoring];
    }
}

#pragma mark - set && get
- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [[AFHTTPSessionManager alloc] init];
        [_manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        _manager.requestSerializer=[AFJSONRequestSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [_manager.requestSerializer setTimeoutInterval:30];
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _manager;
}

- (NSString *)formatUrlStr{
    if (_formatUrlStr.length == 0) {
        _formatUrlStr = [UCNetworkingUrlConfig getFormaterUrl];
    }
    return _formatUrlStr;
}
- (NSHashTable<id<UCNetworkingManagerDelegate>> *)delegateHashTable{
    if (!_delegateHashTable) {
        _delegateHashTable = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    }
    return _delegateHashTable;
}

@end
