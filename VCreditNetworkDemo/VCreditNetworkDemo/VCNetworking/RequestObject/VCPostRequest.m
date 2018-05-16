//
//  VCPostRequest.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/8/4.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCPostRequest.h"
#import "VCNetworkingManager.h"
#import "VCResponsobjParser.h"
#import "VCCacheManger.h"
#import <YYModel.h>

@implementation VCPostRequest

- (void)postWithClass:(Class)classObj Completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))failure{
    
    [self p_postWithClass:classObj isCache:NO cacheUrlStr:nil Completion:completion exceptions:exceptions error:failure];
}

- (void)postWithClass:(Class)classObj Completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))failure cacheUrlStr:(NSString *)cacheUrlStr cacheObjectCallBackBlock:(void (^)(id))cacheObjectCallBackBlock{
    
    //read local disk cache
    if ([[VCCacheManger shareManager] objectIsInCacheWithUrlStr:cacheUrlStr]) {
        id obj = [[VCCacheManger shareManager] readDataFromCacheWithUrlStr:cacheUrlStr];
        if (!obj && [obj isKindOfClass:[NSDictionary class]] && cacheObjectCallBackBlock) {
            VCBaseModel *model = [classObj  yy_modelWithJSON:(NSDictionary *)obj];
            cacheObjectCallBackBlock(model);
        }
    }
    [self p_postWithClass:classObj isCache:YES cacheUrlStr:cacheUrlStr Completion:completion exceptions:exceptions error:failure];
}

#pragma mark private
- (void)p_postWithClass:(Class)classObj isCache:(BOOL)isCache cacheUrlStr:(NSString *)cacheUrlStr Completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))failure{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    VCNetworkingManager *networkingManager = [VCNetworkingManager shareManager];
    AFHTTPSessionManager *manager =networkingManager.manager;
    VCResponsobjParser *parser = networkingManager.parser;
    [manager POST:self.urlStr parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        //cache data to disk
        if (isCache) {
            [[VCCacheManger shareManager] saveDataWithObject:responseObject urlStr:cacheUrlStr];
        }
        
        //success call back
        [parser success:task reponseObject:responseObject class:classObj completion:completion exceptions:exceptions failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
        //error call back
        [parser failure:task httpError:error class:classObj completion:completion failure:failure];
    }];
}

@end
