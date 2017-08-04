//
//  VCGetRequest.h
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/8/4.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCBaseRequest.h"

@interface VCGetRequest : VCBaseRequest

/**
 get
 */
- (void)getWithClass:(Class)classObj Completion:(void (^)(id))completion exceptions:(void (^)(id))exceptions error:(void (^)(NSError *))failure;

@end
