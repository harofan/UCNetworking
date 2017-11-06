//
//  VCGetRequest.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/8/4.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCGetRequest.h"
#import "VCNetworkingManager.h"
#import "VCResponsobjParser.h"

@implementation VCGetRequest

- (void)getWithClass:(Class)classObj Completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))failure{
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    VCNetworkingManager *networkingManager = [VCNetworkingManager shareManager];
    AFHTTPSessionManager *manager =networkingManager.manager;
    VCResponsobjParser *parser = networkingManager.parser;
    
    [manager GET:self.urlStr parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        //success callback
        [parser success:task reponseObject:responseObject class:classObj completion:completion exceptions:exceptions failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        //error callback
        [parser failure:task httpError:error class:classObj completion:completion failure:failure];
    }];
}
@end
