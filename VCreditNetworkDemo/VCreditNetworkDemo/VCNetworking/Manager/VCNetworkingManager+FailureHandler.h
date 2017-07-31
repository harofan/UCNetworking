//
//  VCNetworkingManager+FailureHandler.h
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "VCNetworkingManager.h"

@interface VCNetworkingManager (FailureHandler)

@property (nonatomic, strong) NSMutableSet *failureQueue;
@end
