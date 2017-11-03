//
//  VCResponsobjParser.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCResponsobjParser.h"
#import <YYModel.h>
#import "VCNetworkingManager.h"
#import "VCNetworkingManager+FailureHandler.h"
#import "VCBaseModel.h"

@implementation VCResponsobjParser

- (void)success:(NSURLSessionDataTask *)task reponseObject:(id)responseObject class:(Class)classObj completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))error{
    
    NSDictionary *dict = (NSDictionary *)responseObject;
    
    VCNetworkingManager *networkManager = [VCNetworkingManager shareManager];
    
    if (!exceptions && networkManager.delegate && [networkManager.delegate respondsToSelector:@selector(networingManager:filterResponse:error:)]){
        if ([networkManager.delegate networingManager:networkManager filterResponse:dict error:nil]) {

            return;
        }
    }
    
    if ([classObj isSubclassOfClass:[NSDictionary class]]) {
        completion(dict);
    } else if ([classObj isSubclassOfClass:[NSObject class]]) {
        VCBaseModel *model = [classObj  yy_modelWithJSON:dict];
        if ([[model class] isSubclassOfClass:[VCBaseModel class]])
        {
            
            if (model && completion && [model.status isEqualToString:@"000"]) {
                
                NSLog(@"=====%@",[completion class]);
                completion(model);
                return;
            }
            if (model && exceptions &&![model.status isEqualToString:@"000"]) {
                exceptions(model);
                return;
            }
        }
        
        
        if (model && completion) {
            completion(model);
            return;
        }
        
    }
}

- (void)failure:(NSURLSessionDataTask *)task httpError:(id)httpError class:(Class)classObj completion:(void (^)(id))completion error:(void (^)(NSError *))failre{
    
    if (!task) {
        return;
    }
    
    VCNetworkingManager *networkManager = [VCNetworkingManager shareManager];
    if (networkManager.delegate&&[networkManager.delegate respondsToSelector:@selector(networingManager:filterRetryFailureSessionManager:error:)]) {
        
        if([networkManager.delegate networingManager:networkManager filterRetryFailureSessionManager:networkManager.manager error:false]){
            return;
        }

    }
    
    NSURLSessionDataTask *currnetTask =  [networkManager.manager dataTaskWithRequest:task.currentRequest  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (error) {
            [self failure:task httpError:error class:classObj completion:completion error:failre];
        }else {
            [self success:task reponseObject:responseObject class:classObj completion:completion exceptions:nil error:failre];
        }
    }];
    [networkManager.failureQueue addObject:currnetTask];
}
@end
