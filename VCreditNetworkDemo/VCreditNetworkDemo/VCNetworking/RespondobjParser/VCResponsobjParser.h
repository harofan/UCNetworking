//
//  VCResponsobjParser.h
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCResponsobjParser : NSObject

- (void)success:(NSURLSessionDataTask *)task reponseObject:(id)responseObject class:(Class)classObj completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions failure:(void (^)(NSError *))failure;

- (void)failure:(NSURLSessionDataTask *)task httpError:(id)httpError class:(Class)classObj completion:(void (^)(id))completion failure:(void (^)(NSError *))failure;


@end
