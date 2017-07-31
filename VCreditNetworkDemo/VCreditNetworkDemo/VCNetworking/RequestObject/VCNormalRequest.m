//
//  VCNormalRequest.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCNormalRequest.h"
#import "VCNetworkingManager.h"
#import "VCResponsobjParser.h"

@implementation VCNormalRequest

- (void)postWithClass:(Class)classObj Completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))failure{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    VCNetworkingManager *networkingManager = [VCNetworkingManager shareManager];
    AFHTTPSessionManager *manager =networkingManager.manager;
    VCResponsobjParser *parser = networkingManager.parser;
    [manager POST:self.urlStr parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        //success call back
        [parser success:task reponseObject:responseObject class:classObj completion:completion exceptions:exceptions error:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [parser failure:task httpError:error class:classObj completion:completion error:failure];
    }];
}
@end
