//
//  UCGetRequest.m
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/13.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "UCGetRequest.h"
#import "UCCacheManager.h"

@implementation UCGetRequest
- (NSURLSessionDataTask *)startRequestWithSuccessCallBack:(void (^)(NSDictionary *responseDict))successCallBack
                        failureCallBack:(void (^)(NSError *error))failureCallBack{
    return [self p_getWithIsCache:NO
               cacheUrlStr:self.urlStr
                Completion:successCallBack
                   failure:failureCallBack];
}

- (NSURLSessionDataTask *)startRequestWithCacheCallBack:(void (^)(NSDictionary *cacheDict))cacheCallBack
                      SuccessCallBack:(void (^)(NSDictionary *responseDict))successCallBack
                      failureCallBack:(void (^)(NSError *error))failureCallBack{
    
    if ([[UCCacheManager shareManager] objectIsInCacheWithUrlStr:self.urlStr]) {
        NSDictionary *cacheDict = [[UCCacheManager shareManager] readDataFromCacheWithUrlStr:self.urlStr];
        if (cacheDict && cacheCallBack) {
            cacheCallBack(cacheDict);
        }
    }
    return [self p_getWithIsCache:YES
               cacheUrlStr:self.urlStr
                Completion:successCallBack
                   failure:failureCallBack];
}

#pragma mark - private
- (NSURLSessionDataTask *)p_getWithIsCache:(BOOL)isCache
          cacheUrlStr:(NSString *)cacheUrlStr
           Completion:(void (^)(NSDictionary *responseDict))completion
              failure:(void (^)(NSError *error))failure{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    return [self.httpManager GET:self.urlStr parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (isCache && (!responseObject)) {
            [[UCCacheManager shareManager] saveDataWithObject:responseObject urlStr:cacheUrlStr];
        }
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
    }];
}
@end
