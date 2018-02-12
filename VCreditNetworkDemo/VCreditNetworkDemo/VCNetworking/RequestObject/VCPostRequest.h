//
//  VCPostRequest.h
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/8/4.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCBaseRequest.h"

@interface VCPostRequest : VCBaseRequest

/**
 post
 */
- (void)postWithClass:(Class)classObj Completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))failure;

/**
 post with cache
 */
- (void)postWithClass:(Class)classObj Completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))failure cacheUrlStr:(NSString *)cacheUrlStr cacheObjectCallBackBlock:(void(^)(id cacheObject))cacheObjectCallBackBlock;

@end
