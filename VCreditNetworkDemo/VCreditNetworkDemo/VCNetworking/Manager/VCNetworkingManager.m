//
//  VCNetworkingManager.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCNetworkingManager.h"

#import "VCNormalRequest.h"
#import "VCUploadRequest.h"
#import "VCDownloadRequest.h"
#import "VCBaseRequest.h"
#import "VCUploadImageRequest.h"

#import "VCResponsobjParser.h"


@interface VCNetworkingManager ()

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *api;
@property (nonatomic, strong, readwrite) AFHTTPSessionManager *manager;

@end

@implementation VCNetworkingManager

#pragma mark construct manager
static VCNetworkingManager *_share = nil;
+ (instancetype)shareManager{
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        _share = [[super allocWithZone:NULL] init];
    });
    return _share;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self shareManager];
}

#pragma mark POST
- (void)postUrl:(NSString *)url {
    [self postUrl:url completion:nil];
}

- (void)postUrl:(NSString *)url completion:(void (^)(id))completion {
    [self postUrl:url class:nil completion:completion];
}

- (void)postUrl:(NSString *) url class:(Class)classObj completion:(void(^)(id)) completion{
    [self postUrl:url params:nil class:classObj completion:completion error:nil];
}

- (void)postUrl:(NSString *) url params:(NSDictionary *)params class:(Class)classObj completion:(void(^)(id))completion;{
    [self postUrl:url params:params class:classObj completion:completion error:nil];
}

- (void)postUrl:(NSString *)url params:(NSDictionary *)params class:(Class )classObj completion:(void (^)(id))completion error : (void (^)(NSError *))failure
{
    [self postUrl:url params:params class:classObj completion:completion exceptions:nil error:failure];
}

- (void)postUrl:(NSString *)url params:(NSDictionary *)params class:(Class )classObj completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))failure
{
    NSString *postUrl = [self p_assembledUrl:url];
    VCNormalRequest *normalRequest = (VCNormalRequest *)[[VCBaseRequest alloc] initWithUrlStr:postUrl parameters:params];
    [normalRequest postWithClass:classObj Completion:completion exceptions:exceptions error:failure];
}

#pragma mark POST IMAGE
- (void)postUrl:(NSString *)url images:(NSArray *)imgArray imageFilePathStr:(NSString *)imageFilePathStr progress:(void (^)(NSProgress *  ))progressCallBack completion : (void (^)(id))completion{
    
    [self postUrl:url images:imgArray params:nil imageFilePathStr:imageFilePathStr class:nil progress:progressCallBack completion:completion exceptions:nil error:nil];
}

- (void)postUrl:(NSString *)url images:(NSArray *)imgArray params:(NSDictionary *)params imageFilePathStr:(NSString *)imageFilePathStr class:(Class )classObj progress:(void (^)(NSProgress *  ))progressCallBack completion : (void (^)(id))completion{
    
    [self postUrl:url images:imgArray params:params imageFilePathStr:imageFilePathStr class:classObj progress:progressCallBack completion:completion exceptions:nil error:nil];
}

- (void)postUrl:(NSString *)url images:(NSArray *)imgArray params:(NSDictionary *)params imageFilePathStr:(NSString *)imageFilePathStr class:(Class )classObj progress:(void (^)(NSProgress *  ))progressCallBack completion : (void (^)(id))completion  error : (void (^)(NSError *))failure{
    
    [self postUrl:url images:imgArray params:params imageFilePathStr:imageFilePathStr class:classObj progress:progressCallBack completion:completion exceptions:nil error:failure];
}

- (void)postUrl:(NSString *)url images:(NSArray *)imgArray params:(NSDictionary *)params imageFilePathStr:(NSString *)imageFilePathStr class:(Class )classObj progress:(void (^)(NSProgress *  ))progressCallBack completion : (void (^)(id))completion exceptions:(void (^)(id))exceptions error : (void (^)(NSError *))failure{
    
    NSString *postUrl = [self p_assembledUrl:url];
    
    VCUploadImageRequest *uploadImageRequest = (VCUploadImageRequest *)[[VCBaseRequest alloc] initWithRequestType:VCNetworkRequestUploadImageType HTTPMethod:VCPostHttpType urlStr:postUrl parameters:params];
    
    [uploadImageRequest postWithimages:imgArray imageFilePathStr:imageFilePathStr classObj:classObj progress:progressCallBack uploadProgressCompletion:completion exceptions:exceptions error:failure];
}

#pragma mark public
- (void)setRequestHeaderField:(NSString *)accessToken{
    NSLog(@"current token:%@",accessToken);
    [_manager.requestSerializer setValue:accessToken forHTTPHeaderField:@"accessToken"];
}

#pragma mark private
- (NSString *)p_assembledUrl:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    if (url.host && url.scheme)
        return urlStr;
    else
        return [NSString stringWithFormat:@"%@%@", self.baseUrl, url];
}

#pragma mark set && get
- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [[AFHTTPSessionManager alloc] init];
        [_manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        _manager.requestSerializer=[AFJSONRequestSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
        
        //
    }
    return _manager;
}

- (VCResponsobjParser *)parser{
    if (nil == _parser) {
        _parser = [[VCResponsobjParser alloc] init];
    }
    return _parser;
}

- (NSString *)baseUrl {
    if (!_baseUrl) {
        _baseUrl = [NSString stringWithFormat:@"%@%@", self.host, self.api];
    }
    return _baseUrl;
}

- (NSString *)api {
    if (!_api) {
        _api = @"/app";
    }
    return _api;
}

- (NSString *)host {
    if (!_host) {
        _host = @"http://10.138.60.143:10000";
    }
    return _host;
}
@end
